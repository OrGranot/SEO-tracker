class SearchController < ApplicationController
  def add
    website = Website.find(params[:website_id])
    @keywords = website.keywords
    @keywords.each do |keyword|
      search = keyword.searches.select {|s| s[:date] == Date.today}
      unless search != []
        search = Search.new(date: Date.today, rank: rand(1..50), engine: 'Google')
        search.keyword = keyword
        search.save
      end

    end
    redirect_to website
  end
end
