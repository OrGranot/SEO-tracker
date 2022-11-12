class KeywordsController < ApplicationController
  def index
    # @website = Website.find(params[:website_id])
    # @q = @website.keywords.ransack(params[:q])

    # @keywords = @q.result(distinct: true)

    # @dates = @keywords.map { |keyword| keyword.searches.map(&:date) }
    # @dates = @dates.flatten.uniq.sort
    @website = Website.find(params[:website_id])
  end

  def new
    @website = Website.find(params[:website_id])
    @keyword = Keyword.new()
  end

  def create
    @keyword = Keyword.new(keyword_params)
    @keyword.key_string.strip!
    @website = Website.find(params[:website_id])
    @keyword.website = @website
    @keyword.save
    redirect_to website_path(@website)
  end

  def destroy
    @keyword = Keyword.find(params[:id])
    @keyword.destroy
    redirect_to(@keyword.website)
  end

  private

  def keyword_params
    params.require(:keyword).permit(:key_string)
  end
end
