class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_last_seen_at, if: proc { user_signed_in? && (session[:last_seen_at] == nil || session[:last_seen_at] < 1.minutes.ago) }

  protected

  def set_last_seen_at
    current_user.update_column(:last_seen_at, Time.current)
    session[:last_seen_at] = Time.current
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password) }
  end
end
