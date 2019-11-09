class ApplicationController < ActionController::Base

  include QueryHelper

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :authenticate_user!

  attr_accessor :current_client

  protected

  def super_admin?
    current_user&.super_admin?
  end

  def admin?
    current_user && (current_user.super_admin? || current_user.admin?)
  end

  def current_client
    @current_client || current_user.client
  end

  def current_invitations
    @current_invitations = super_admin? ? Invitation.all : current_client.invitations
  end

  def current_apps
    @current_apps = if super_admin?
      App.all
    end
  end

  def current_versions
    @current_versions = if super_admin?
      Version.all
    end
  end

  def authorize_super_admin
    unless super_admin?
      redirect_to(root_path)
    end
  end

  def authorize_admin
    unless admin?
      redirect_to(root_path)
    end
  end

  def current_clients
    @current_clients = if super_admin?
       Client.all.order(:name)
     else
       Client.all.visible.order(:name)
     end
  end

  def current_users
    @current_users = if super_admin?
       User.all
     elsif admin?
       User.all
     else
       current_user.client.users.visible
     end
  end

  def set_locale
    I18n.locale = current_user&.locale || current_user&.client&.locale || I18n.default_locale
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :company_name, :send_to])
  end

  helper_method :current_clients, :current_apps, :current_users, :current_users, :super_admin?, :admin?
end
