class AppsController < ApplicationController

  before_action :authorize_super_admin

  before_action :set_app, only: [:edit, :update, :destroy]

  def index
    @apps = current_apps
                 .where(filter_query)
                 .order(sorting_query('name ASC'))
  end

  def new
    @app = App.new
  end

  def edit
  end

  def create
    @app = current_apps.new(app_params)

    if @app.save
      redirect_to apps_path, notice: t('app.app_was_successfully_created')
    else
      render :new
    end
  end

  def update
    if @app.update(app_params)
      redirect_to apps_path, notice: t('app.app_was_successfully_edited')
    else
      render :edit
    end
  end

  def destroy
    @app.hide!

    redirect_to apps_url, notice: t('app.app_was_successfully_deleted')
  end

  def batch_destroy
    @apps = App.where(id: params[:ids])
    @apps.each { |app| app.hide! }

    redirect_to apps_url, notice: t('app.apps_was_successfully_deleted')
  end

  private

  def set_app
    @app = App.find(params[:id])
  end

  def app_params
    params.require(:app).permit(
      :name,
      :hidden,
      :hidden_at
    )
  end

end
