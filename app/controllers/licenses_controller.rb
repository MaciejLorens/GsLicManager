class LicensesController < ApplicationController

  before_action :authorize_admin, only: [:new, :edit, :create, :update, :destroy, :batch_destroy]

  before_action :set_license, only: [:show, :edit, :update, :destroy, :generate_unlock_code]

  def index
    @licenses = current_licenses
                 .includes(:type, :app, :version, :client)
                 .where(filter_query)
                 .order(sorting_query('created_at DESC'))
  end

  def new
    @license = License.new
  end

  def edit
  end

  def show
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

  def generate_unlock_code
    referrer = Rails.application.routes.recognize_path(request.referrer)
    @license.generate_unlock_code(1)

    redirect_to action: referrer[:action]
  end

  private

  def set_license
    @license = License.find(params[:id])
  end

  def license_params
    params.require(:license).permit(
      :end_client_name,
      :end_client_address,
      :status,
      :description,
      :order_number,
      :registration_key,
      :type_id,
      :version_id,
      :user_id,
      :client_id,
      :quantity,
      :hidden,
      :hidden_at,
    )
  end

end
