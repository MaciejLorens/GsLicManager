class ClientsController < ApplicationController

  before_action :authorize_admin

  before_action :set_client, only: [:edit, :update, :destroy]

  def index
    @clients = current_clients
                 .where(filter_query)
                 .includes(:company)
                 .order(sorting_query('name ASC'))
  end

  def new
    @client = Client.new
  end

  def edit
  end

  def create
    @client = current_clients.new(client_params)

    if @client.save
      redirect_to clients_path, notice: t('client.client_was_successfully_created')
    else
      render :new
    end
  end

  def update
    if @client.update(client_params)
      redirect_to clients_path, notice: t('client.client_was_successfully_edited')
    else
      render :edit
    end
  end

  def destroy
    @client.hide!

    redirect_to clients_url, notice: t('client.client_was_successfully_deleted')
  end

  def batch_destroy
    @clients = Client.where(id: params[:ids])
    @clients.each { |client| client.hide! }

    redirect_to clients_url, notice: t('client.clients_was_successfully_deleted')
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(
      :code,
      :name,
      :address,
      :postcode,
      :city,
      :country,
      :hidden,
      :hidden_at,
      :company_id
    )
  end

end
