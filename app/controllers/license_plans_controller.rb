class LicensePlansController < ApplicationController

  before_action :authorize_super_admin

  before_action :set_license_plan, only: [:edit, :update, :destroy]

  def index
    @license_plans = current_license_plans
               .where(filter_query)
               .order(sorting_query('val_pl ASC'))
  end

  def new
    @license_plan = LicensePlan.new
  end

  def edit
  end

  def create
    @license_plan = current_license_plans.new(license_plan_params)

    if @license_plan.save
      redirect_to license_plans_path, notice: t('license_plan.license_plan_was_successfully_created')
    else
      render :new
    end
  end

  def update
    if @license_plan.update(license_plan_params)
      redirect_to license_plans_path, notice: t('license_plan.license_plan_was_successfully_edited')
    else
      render :edit
    end
  end

  def destroy
    @license_plan.hide!

    redirect_to license_plans_url, notice: t('license_plan.license_plan_was_successfully_deleted')
  end

  def batch_destroy
    @license_plans = LicensePlan.where(id: params[:ids])
    @license_plans.each { |plan| plan.hide! }

    redirect_to license_plans_url, notice: t('license_plan.license_plans_was_successfully_deleted')
  end

  private

  def set_license_plan
    @license_plan = LicensePlan.find(params[:id])
  end

  def license_plan_params
    params.require(:license_plan).permit(
      :val_pl,
      :val_en,
      :hidden,
      :hidden_at
    )
  end

end
