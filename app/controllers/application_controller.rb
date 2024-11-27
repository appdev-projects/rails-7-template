class ApplicationController < ActionController::Base
  include Pundit
  skip_forgery_protection

  before_action :authenticate_employee!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, :keys => [:employee_number, :email, :first_name, :last_name, :role_id, :shop_id])

    devise_parameter_sanitizer.permit(:account_update, :keys => [:email, :first_name, :last_name])
  end

  rescue_from Pundit::NotAuthorizedError, with: :employee_not_authorized

  #Ensures that any use of current_user by Devise is replaced by current_employee method
  def current_user
    current_employee
  end

  private

  def employee_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back fallback_location: root_url
  end
end
