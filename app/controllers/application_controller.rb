class ApplicationController < ActionController::Base
  skip_forgery_protection
  before_action :configure_permitted_parameters, if: :devise_controller?


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:username, :email, :last_name, :avatar,:age, :gender, :occupation, :location, :budget, :bio, :instagram_url, :facebook_url, :video_url, :password, :password_confirmation, :current_password)
    end
  end
end
