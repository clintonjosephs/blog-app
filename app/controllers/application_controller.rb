# class ApplicationController < ActionController::Base
#   add_flash_types :danger, :info, :warning, :success, :messages, :notice, :alert
# end

class ApplicationController < ActionController::Base
  add_flash_types :danger, :info, :warning, :success, :messages, :notice, :alert

  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:Name, :Bio, :Photo, :password, :password_confirmation, :email) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:Name, :Bio, :Photo, :password, :password_confirmation, :email)}
  end
end