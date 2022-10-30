class SharedWebsitesController < ApplicationController
  before_action :set_shared_website, only: %i[ show edit update destroy ]
  before_action :set_websites

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
    redirect_to root_path if validate_website(params[:website_id]) == false
    @shared_website = SharedWebsite.new
  end

  def create
    if validate_website(params[:shared_website][:website_id])
      user = User.find_by(email: params[:shared_website][:user].downcase)
      website = Website.find(params[:shared_website][:website_id].to_i)
      role = 'viewer' if params[:shared_website][:role] == 'צפיה בלבד'
      role = 'editor' if params[:shared_website][:role] == 'עריכה'
      @shared_website = SharedWebsite.new
      @shared_website.user = user
      @shared_website.website = website
      @shared_website.role = role

      respond_to do |format|
        if @shared_website.save
          format.html { redirect_to website_path(@shared_website.website), notice: "Shared website was successfully created." }
          format.json { render :show, status: :created, location: @shared_website }
        else
          format.html { redirect_to website_path(@shared_website.website), notice: "User already shared" }
          format.json { render json: @shared_website.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    @shared_website.destroy

    respond_to do |format|
      format.html { redirect_to websites_path, notice: "Shared website was successfully destroyed." }
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

  def validate_website(id)
    id.to_i
    Website.exists?(id) && Website.find(id).user == current_user
  end

  def set_websites
    @websites = current_user.websites.all
    @shared_websites = current_user.shared_websites.all
  end
end
