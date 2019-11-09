class TypesController < ApplicationController

  before_action :authorize_super_admin

  before_action :set_type, only: [:edit, :update, :destroy]

  def index
    @types = current_types
                 .where(filter_query)
                 .order(sorting_query('value ASC'))
  end

  def new
    @type = Type.new
  end

  def edit
  end

  def create
    @type = current_types.new(type_params)

    if @type.save
      redirect_to types_path, notice: t('type.type_was_successfully_created')
    else
      render :new
    end
  end

  def update
    if @type.update(type_params)
      redirect_to types_path, notice: t('type.type_was_successfully_edited')
    else
      render :edit
    end
  end

  def destroy
    @type.hide!

    redirect_to types_url, notice: t('type.type_was_successfully_deleted')
  end

  def batch_destroy
    @types = Type.where(id: params[:ids])
    @types.each { |type| type.hide! }

    redirect_to types_url, notice: t('type.types_was_successfully_deleted')
  end

  private

  def set_type
    @type = Type.find(params[:id])
  end

  def type_params
    params.require(:type).permit(
      :value,
      :en,
      :pl,
      :hidden,
      :hidden_at
    )
  end

end
