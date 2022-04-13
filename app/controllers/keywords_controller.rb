class KeywordsController < ApplicationController
  def create
    @keyword = Keyword.new(keyword_params)
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
