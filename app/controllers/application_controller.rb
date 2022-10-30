class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_websites

  private

  def set_websites
    @websites = current_user.websites.all
    @shared_websites = current_user.shared_websites.all
  end
end
