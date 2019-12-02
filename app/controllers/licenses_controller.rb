class LicensesController < ApplicationController

  before_action :authorize_admin, only: [:new, :edit, :create, :update, :destroy, :batch_destroy]

  before_action :set_license, only: [:show, :edit, :history, :update, :duplicate, :register, :registration, :destroy]

  def index
    @licenses = current_licenses
                 .includes(:license_type, :app, :version, :plan, :client, :license_status, :user)
                 .where(filter_query)
                 .order(sorting_query('created_at DESC'))
  end

  def new
    @license = License.new
  end

  def duplicate
    status_id = LicenseStatus.find_by(val_en: 'New')
    type_id = LicenseType.find_by(val_en: params[:type]).id
    @license = License.new(@license.attributes.merge(license_type_id: type_id, license_status_id: status_id))
  end

  def edit
  end

  def register
  end

  def show
  end

  def history
  end

  def create
    params[:quantity].to_i.times do |index|
      current_licenses.create(license_params)
    end

    redirect_to licenses_path, notice: t('license.license_was_successfully_created')
  end

  def update
    if @license.update(license_params)
      redirect_to licenses_path, notice: t('license.license_was_successfully_edited')
    else
      render :edit
    end
  end

  def destroy
    @license.hide!

    redirect_to licenses_url, notice: t('license.license_was_successfully_deleted')
  end

  def batch_destroy
    @licenses = License.where(id: params[:ids])
    @licenses.each { |license| license.hide! }

    redirect_to licenses_url, notice: t('license.licenses_was_successfully_deleted')
  end

  def registration
    if @license.update(license_registration_params)
      @license.generate_unlock_code(current_user, 1)
      redirect_to licenses_path, notice: t('license.license_was_successfully_registered')
    else
      render :edit
    end
  end

  private

  def set_license
    @license = License.find(params[:id])
  end

  def license_params
    params.require(:license).permit(
      :client_id,
      :app_id,
      :version_id,
      :plan_id,
      :license_type_id,
      :license_status_id,
      :order_number,
      :end_client_name,
      :installation_address,
      :description,
      :registration_key,
      :user_id,
      :origin_id,
      :quantity,
      :hidden,
      :hidden_at,
    )
  end

  def license_registration_params
    params.require(:license).permit(
      :end_client_name,
      :installation_address,
      :description,
      :registration_key,
    )
  end

end
