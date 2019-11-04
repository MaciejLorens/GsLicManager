class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :authenticate_user!

  attr_accessor :current_company

  protected

  def current_company
    @current_company || current_user.company
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :company_name, :send_to])
  end

  helper_method :current_company
end
