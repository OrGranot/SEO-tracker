class SearchController < ApplicationController
  def add
    website = Website.find(params[:website_id])
    @keywords = website.keywords
    @keywords.each do |keyword|

      lastSearch = keyword.searches.last
      if !lastSearch || !lastSearch.created_at.strftime("%d/%m/%Y") == Date.today.strftime("%d/%m/%Y")
        search = Search.new(date: Date.today, rank: rand(1..50), engine: 'Google')
        search.keyword = keyword
        search.save
        keyword.lastSearch = search.created_at


      end
    end
    redirect_to website
  end
end
