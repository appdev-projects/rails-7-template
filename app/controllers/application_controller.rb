class ApplicationController < ActionController::Base
  skip_forgery_protection

  #before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, :keys => [:employee_number, :email, :first_name, :last_name, :role_id, :store_number])

    devise_parameter_sanitizer.permit(:account_update, :keys => [:email, :first_name, :last_name])
  end
end
