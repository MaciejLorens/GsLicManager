class ApplicationController < ActionController::Base

  include QueryHelper

  before_action :set_locale

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :authenticate_user!

  skip_before_action :verify_authenticity_token, only: [:batch_destroy]

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
    @current_invitations = if super_admin?
                             Invitation.all
                           elsif admin?
                             Invitation.all.visible
                           end
  end

  def current_licenses
    @current_apps = if super_admin?
                      License.all
                    elsif admin?
                      License.all.visible
                    else
                      current_client.licenses
                    end
  end

  def current_license_types
    @current_license_types = if super_admin?
                       LicenseType.all
                     elsif admin?
                       LicenseType.all.visible
                     else
                       license_type_ids = current_licenses.pluck(:license_type_id).uniq
                       LicenseType.where(id: license_type_ids)
                     end
  end

  def current_license_statuses
    @current_license_statuses = if super_admin?
                       LicenseStatus.all
                     elsif admin?
                       LicenseStatus.all.visible
                     else
                       license_status_ids = current_licenses.pluck(:license_status_id).uniq
                       LicenseStatus.where(id: license_status_ids)
                     end
  end

  def current_versions
    @current_versions = if super_admin?
                          Version.all
                        elsif admin?
                          Version.all.visible
                        else
                          version_ids = current_licenses.pluck(:version_id).uniq
                          Version.where(id: version_ids)
                        end
  end

  def current_apps
    @current_apps = if super_admin?
                      App.all
                    elsif admin?
                      App.all.visible
                    else
                      version_ids = current_licenses.map(&:version_id).uniq
                      app_ids = Version.where(id: version_ids).pluck(:app_id).uniq
                      App.where(id: app_ids)
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
                         Client.all
                       else
                         Client.all.visible
                       end
  end

  def current_users
    @current_users = if super_admin?
                       User.all
                     elsif admin?
                       User.all.visible
                     else
                       current_user.client.users.visible
                     end
  end

  def set_locale
    I18n.locale = (current_user&.locale || current_user&.client&.locale || I18n.default_locale).to_sym
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :company_name, :send_to])
  end

  helper_method :current_clients, :current_apps, :current_users, :current_users, :current_licenses,
                :current_license_types, :current_license_statuses, :current_versions, :super_admin?, :admin?
end
