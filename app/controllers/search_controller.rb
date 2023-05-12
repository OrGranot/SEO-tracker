class SearchController < ApplicationController
  before_action :set_website, only: %i[add_ranks create]

  def add_ranks
    @keywords = @website.keywords
    @keywords.each do |keyword|
      search = keyword.searches.select { |s| s[:date] == Date.today }
      next if search != []

      rank = find_rank(keyword)
      if rank == false
        flash[:notice] = 'שגיאה בקריאת נתונים'
        redirect_to website_path(website) and break
      elsif rank.positive?
        search = Search.new(date: Date.today, rank: rank, engine: 'Google')
        search.keyword = keyword
        search.save
      end
    end
    redirect_to @website
  end

  def create()
    @keyword = Keyword.find(params[:keyword_id])
    if !@keyword.searches.last.nil? && @keyword.searches.last.date == Date.today && @keyword.searches.last.date != []
      redirect_to @website and return
    end

        SearchRankWorker.perform_async(@keyword.id)
    # rank = find_rank(@keyword)


    # if rank == false
    #   flash[:notice] = 'שגיאה בקריאת נתונים'
    #   redirect_to website_path(@website) and return
    # elsif rank.positive?
    #   search = Search.new(date: Date.today, rank: rank, engine: 'Google', keyword: @keyword)
    #   search.save
    # end
    redirect_to @website
  end



  private

  # def find_rank(keyword)
  #   domain = (keyword.website.url.downcase).split('.')
  #   domain.shift
  #   domain = domain.join('.')

  #   results = api_call(keyword)
  #   return false if results["request_info"]["success"] == false

  #   results["organic_results"].each do |result|


  #     return result["position"] if result["domain"].include?(domain)
  #   end

  #   return -1
  # end


  # def api_call(query, country = "il")
  #   require 'uri'
  #   require 'net/http'
  #   require 'openssl'

  #   uri = URI("https://api.valueserp.com/search")

  #   params = { api_key: ENV.fetch('VALUESERP_API_KEY'), q: query.key_string, gl: country, num: 100 }
  #   uri.query = URI.encode_www_form(params)

  #   res = Net::HTTP.get_response(uri)
  #   return JSON.parse(res.read_body)
  # end

  def set_website
    @website = Website.find_by_id(params[:website_id])
    redirect_to websites_path, alert: "Action unauthorized" if @website.nil? || @website.user != current_user
  end
end
