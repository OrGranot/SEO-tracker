class WebsitesController < ApplicationController
  before_action :set_website, only: %i[ show edit update destroy ]

  # GET /websites or /websites.json
  def index
    @websites = Website.where(user: current_user)
    @shared_websites = SharedWebsite.where(user: current_user)
  end

  # GET /websites/1 or /websites/1.json

  def show
    @keywords = @website.keywords
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
    @shared_website = SharedWebsite.new
  end

  # GET /websites/new
  def new
    @website = Website.new
  end

  # GET /websites/1/edit
  def edit
  end

  # POST /websites or /websites.json
  def create
    @website = Website.new(website_params)
    @website.url = @website.url.gsub(/(^https?\:\/\/|(\/|\?).*$)/, '')
    @website.user = current_user
    respond_to do |format|
      if @website.save
        format.html { redirect_to website_url(@website), notice: "Website was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /websites/1 or /websites/1.json
  def update
    respond_to do |format|
      if @website.update(website_params)
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
    # Use callbacks to share common setup or constraints between actions.
    def set_website
      @website = Website.find(params[:id])
      redirect_to root_path, alert: "Action unauthorized" if @website.user != current_user
    end

    # Only allow a list of trusted parameters through.
    def website_params
      params.require(:website).permit(:name, :url)
    end
end
