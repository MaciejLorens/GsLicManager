class LicensesController < ApplicationController

  before_action :authorize_admin

  before_action :set_license, only: [:edit, :update, :destroy]

  def index
    @licenses = current_licenses
                 .includes(:type, :version, :client)
                 .where(filter_query)
                 .order(sorting_query('created_at ASC'))
  end

  def new
    @license = License.new
  end

  def edit
  end

  def create
    @license = current_licenses.new(license_params)

    if @license.save
      redirect_to licenses_path, notice: t('license.license_was_successfully_created')
    else
      render :new
    end
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

  private

  def set_license
    @license = License.find(params[:id])
  end

  def license_params
    params.require(:license).permit(
      :name,
      :locale,
      :hidden,
      :hidden_at
    )
  end

end
