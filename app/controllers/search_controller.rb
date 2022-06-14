class SearchController < ApplicationController
  def add
    website = Website.find(params[:website_id])
    @keywords = website.keywords
    @keywords.each do |keyword|
      search = keyword.searches.select {|s| s[:date] == Date.today}
      unless search != []
        rank = find_rank(keyword)
        if rank > 0 then
          search = Search.new(date: Date.today, rank: rank, engine: 'Google')
          search.keyword = keyword
          search.save
        end
      end
    end
    redirect_to website
  end


  private 
  
  def find_rank(keyword)
    results = api_call(keyword)
    results["organic_results"].each do |result|
      if result["domain"] == (keyword.website.url) then return result["position"] end
    end
    return -1
  end

  def api_call(query, gl = "il")
    require 'uri'
    require 'net/http'
    require 'openssl'

    uri = URI("https://api.valueserp.com/search")

    params = { :api_key => "5996D87454614FAA8AC47EF89787C904", :q => query.key_string, :gl => gl, :num => 100 }
    uri.query = URI.encode_www_form(params)

    res = Net::HTTP.get_response(uri)
    results = JSON.parse(res.read_body)
  end 
end
