class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_websites

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
  private

  def set_websites
    if user_signed_in?
      @websites = current_user.websites.all
      @shared_websites = current_user.shared_websites.all
    end
  end
end
