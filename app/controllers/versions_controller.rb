class VersionsController < ApplicationController

  before_action :authorize_super_admin

  before_action :set_version, only: [:edit, :update, :destroy]

  def index
    @versions = current_versions
                 .includes(:app)
                 .where(filter_query)
                 .order(sorting_query('value asc'))
  end

  def new
    @version = Version.new
  end

  def edit
  end

  def create
    @version = current_versions.new(version_params)

    if @version.save
      redirect_to versions_path, notice: t('version.version_was_successfully_created')
    else
      render :new
    end
  end

  def update
    if @version.update(version_params)
      redirect_to versions_path, notice: t('version.version_was_successfully_edited')
    else
      render :edit
    end
  end

  def destroy
    @version.hide!

    redirect_to versions_url, notice: t('version.version_was_successfully_deleted')
  end

  def batch_destroy
    @versions = Version.where(id: params[:ids])
    @versions.each { |version| version.hide! }

    redirect_to versions_url, notice: t('version.versions_was_successfully_deleted')
  end

  private

  def set_version
    @version = Version.find(params[:id])
  end

  def version_params
    params.require(:version).permit(
      :value,
      :number,
      :app_id,
      :hidden,
      :hidden_at,
    )
  end

end
