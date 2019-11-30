class PlansController < ApplicationController

  before_action :authorize_super_admin

  before_action :set_plan, only: [:edit, :update, :destroy]

  def index
    @plans = current_plans
               .includes(:app)
               .where(filter_query)
               .order(sorting_query('val_pl ASC'))
  end

  def new
    @plan = Plan.new
  end

  def edit
  end

  def create
    @plan = current_plans.new(plan_params)

    if @plan.save
      redirect_to plans_path, notice: t('plan.plan_was_successfully_created')
    else
      render :new
    end
  end

  def update
    if @plan.update(plan_params)
      redirect_to plans_path, notice: t('plan.plan_was_successfully_edited')
    else
      render :edit
    end
  end

  def destroy
    @plan.hide!

    redirect_to plans_url, notice: t('plan.plan_was_successfully_deleted')
  end

  def batch_destroy
    @plans = Plan.where(id: params[:ids])
    @plans.each { |plan| plan.hide! }

    redirect_to plans_url, notice: t('plan.plans_was_successfully_deleted')
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(
      :val_pl,
      :val_en,
      :hidden,
      :hidden_at,
      :app_id
    )
  end

end
