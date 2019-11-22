class LicenseTypesController < ApplicationController

  before_action :authorize_super_admin

  before_action :set_license_type, only: [:edit, :update, :destroy]

  def index
    @license_types = current_license_types
               .where(filter_query)
               .order(sorting_query('val_pl ASC'))
  end

  def new
    @license_type = LicenseType.new
  end

  def edit
  end

  def create
    @license_type = current_license_types.new(license_type_params)

    if @license_type.save
      redirect_to license_types_path, notice: t('license_type.license_type_was_successfully_created')
    else
      render :new
    end
  end

  def update
    if @license_type.update(license_type_params)
      redirect_to license_types_path, notice: t('license_type.license_type_was_successfully_edited')
    else
      render :edit
    end
  end

  def destroy
    @license_type.hide!

    redirect_to license_types_url, notice: t('license_type.license_type_was_successfully_deleted')
  end

  def batch_destroy
    @license_types = LicenseType.where(id: params[:ids])
    @license_types.each { |type| type.hide! }

    redirect_to license_types_url, notice: t('license_type.license_types_was_successfully_deleted')
  end

  private

  def set_license_type
    @license_type = LicenseType.find(params[:id])
  end

  def license_type_params
    params.require(:license_type).permit(
      :val_pl,
      :val_en,
      :hidden,
      :hidden_at
    )
  end

end
