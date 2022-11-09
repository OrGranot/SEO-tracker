class WebsitesController < ApplicationController
  before_action :set_website, only: %i[ show edit update destroy]
  before_action :set_websites

  # GET /websites or /websites.json
  def index
    @website = Website.new
    @websites = Website.where(user: current_user)
    @shared_websites = SharedWebsite.where(user: current_user)
    @shared_website = SharedWebsite.new
  end

  # GET /websites/1 or /websites/1.json

  def show
    # @keywords = @website.keywords
    @keywords = @website.keywords
    @dates = @keywords.map { |keyword| keyword.searches.map(&:date) }
    @dates = @dates.flatten.uniq.sort
    hash_keywords
    @shared_website = SharedWebsite.new
    # @website.keywords.joins(:searches).group(:id).last.searches.chart_json

  end

  # POST /websites or /websites.json
  def create
    @website = Website.new(website_params)
    @website.url = @website.url.gsub(%r{(^https?://|(/|\?).*$)}, '').downcase
    @website.user = current_user

    if @website.save
      redirect_to website_url(@website)
    else
      redirect_to websites_path
    end
  end

  # PATCH/PUT /websites/1 or /websites/1.json
  def update
    respond_to do |format|
      if @website.update(website_params_update)
        format.html { redirect_to website_url(@website), notice: "Website was successfully updated." }
        format.json { render :show, status: :ok, location: @website }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /websites/1 or /websites/1.json
  def destroy
    @website.destroy

    respond_to do |format|
      format.html { redirect_to websites_url, notice: "Website was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def hash_keywords
    @arr = []
    @keywords.each do |keyword|
      hased_keyword = Hash.new(keyword)
      @dates.each do |date|
        hased_keyword[date] = keyword.searches.where(date: date)
        @arr << hased_keyword
      end
    end
    @arr
  end

  def set_website
    @website = Website.find_by_id(params[:id])
    redirect_to websites_path, alert: "Action unauthorized" if @website.nil? || @website.user != current_user
  end

  def set_websites
    @websites = current_user.websites.all
    @shared_websites = current_user.shared_websites.all
  end

  # Only allow a list of trusted parameters through.
  def website_params
    params.require(:website).permit(:name, :url)
  end

  def website_params_update
    params.require(:website).permit(:name)
  end
end
