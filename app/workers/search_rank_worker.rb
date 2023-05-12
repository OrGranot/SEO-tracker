require 'uri'
require 'net/http'
require 'openssl'


class SearchRankWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(keyword_id)
    begin
      keyword = Keyword.find(keyword_id)
      rank = find_rank(keyword)
      if (rank.positive?)
        search = Search.new(date: Date.today, rank: rank, engine: 'Google', keyword: keyword)
        search.save
      end
    rescue StandardError => e
      # Log the error with more details
      Rails.logger.error("SearchRankWorker failed with error (#{e.class}): #{e.message}\n#{e.backtrace.join("\n")}")
    end
  end

  private

  def find_rank(keyword)
    domain = (keyword.website.url.downcase).split('.')
    domain.shift
    domain = domain.join('.')

    results = api_call(keyword)
    return false if results["request_info"]["success"] == false

    results["organic_results"].each do |result|


      return result["position"] if result["domain"].include?(domain)
    end

    return -1
  end


  def api_call(query, country = "il")

    uri = URI("https://api.valueserp.com/search")

    params = { api_key: ENV.fetch('VALUESERP_API_KEY'), q: query.key_string, gl: country, num: 100 }
    uri.query = URI.encode_www_form(params)

    res = Net::HTTP.get_response(uri)
    return JSON.parse(res.read_body)
  end
end
