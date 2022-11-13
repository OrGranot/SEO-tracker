class SharedWebsitesController < ApplicationController
  before_action :set_shared_website, only: %i[show edit update destroy]
  before_action :set_websites

  def show
    @q = @website.website.keywords.ransack(params[:q])
    @q.sorts = 'created_at desc' if @q.sorts.empty?
    @keywords = @q.result(distinct: true)
    # @keywords = @shared_website.website.keywords
    @dates = @keywords.map do |keyword|
      keyword.searches.map {|search| search.date }
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
      @shared_website = SharedWebsite.new(shared_website_params)
      @shared_website.user = User.find_by(email: params[:shared_website][:user].downcase)

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
    @swebsite = SharedWebsite.find_by_id(params[:id])
    redirect_to websites_path if @shared_website.nil?
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
