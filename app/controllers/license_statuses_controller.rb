class LicenseStatusesController < ApplicationController

  before_action :authorize_super_admin

  before_action :set_license_status, only: [:edit, :update, :destroy]

  def index
    @license_statuses = current_license_statuses
               .where(filter_query)
               .order(sorting_query('val_pl ASC'))
  end

  def new
    @license_status = LicenseStatus.new
  end

  def edit
  end

  def create
    @license_status = current_license_statuses.new(license_status_params)

    if @license_status.save
      redirect_to license_statuses_path, notice: t('license_status.license_status_was_successfully_created')
    else
      render :new
    end
  end

  def update
    if @license_status.update(license_status_params)
      redirect_to license_statuses_path, notice: t('license_status.license_status_was_successfully_edited')
    else
      render :edit
    end
  end

  def destroy
    @license_status.hide!

    redirect_to license_statuses_url, notice: t('license_status.license_status_was_successfully_deleted')
  end

  def batch_destroy
    @license_statuses = LicenseStatus.where(id: params[:ids])
    @license_statuses.each { |status| status.hide! }

    redirect_to license_statuses_url, notice: t('license_status.license_statuses_was_successfully_deleted')
  end

  private

  def set_license_status
    @license_status = LicenseStatus.find(params[:id])
  end

  def license_status_params
    params.require(:license_status).permit(
      :val_pl,
      :val_en,
      :hidden,
      :hidden_at
    )
  end

end
