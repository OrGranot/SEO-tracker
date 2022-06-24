class SharedWebsitesController < ApplicationController
  before_action :set_shared_website, only: %i[ show edit update destroy ]

  def show
    @keywords = @shared_website.website.keywords
    @dates = @keywords.map do |keyword|
      keyword.searches.map {|search| search.date}
    end
    @dates = @dates.flatten.uniq.sort
    @arr = []
    @keywords.each do |keyword|
      hased_keyword = Hash.new(keyword)
      @dates.each do |date|
        hased_keyword[date] = keyword.searches.where(date: date)

        @arr << hased_keyword
      end
    end
  end

  def new
    @shared_website = SharedWebsite.new
  end

  def create
    @shared_website = SharedWebsite.new(shared_website_params)

    respond_to do |format|
      if @shared_website.save
        format.html { redirect_to shared_website_url(@shared_website), notice: "Shared website was successfully created." }
        format.json { render :show, status: :created, location: @shared_website }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shared_website.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @shared_website.destroy

    respond_to do |format|
      format.html { redirect_to shared_websites_url, notice: "Shared website was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_shared_website
    @shared_website = SharedWebsite.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def shared_website_params
    params.require(:shared_website).permit(:website_id, :user_id, :role)
  end
end
