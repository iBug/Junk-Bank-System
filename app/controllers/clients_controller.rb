class ClientsController < ApplicationController
  include AccountsHelper

  before_action :set_client, only: %i[edit update destroy accounts loans]

  # GET /clients
  def index
    @clients = Client.joins(:contact, :manager).order(:id).select('clients.*', 'contacts.name AS contact_name', 'staffs.name AS manager_name')
  end

  # GET /clients/1
  def show
    @client = Client.joins(:contact, :manager).select('clients.*', 'contacts.name AS contact_name', 'staffs.name AS manager_name').find(params[:id])
  end

  # GET /clients/1/contact
  def contact
    @contact = Contact.joins(:client).select('contacts.*', 'clients.name AS client_name').find_by(client_id: params[:id])
  end

  # GET /clients/1/accounts
  def accounts
    @accounts = Ownership.joins(:account, :branch).where(client: @client).select('ownerships.*', 'accounts.balance AS balance', 'branches.name AS branch_name')
  end

  # GET /clients/1/loans
  def loans
    @loans = Loan.joins(:clients, :branch).where('clients.id = ?', @client.id).select('loans.*', 'branches.name AS branch_name')
  end

  # GET /clients/new
  def new
    @client = Client.new
    @client.build_contact
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  def create
    @client = Client.new(client_params)

    if @client.save
      redirect_to @client, success: '成功创建客户'
    else
      render :new
    end
  end

  # PATCH/PUT /clients/1
  def update
    if @client.update(client_params)
      redirect_to @client, success: '成功更新客户'
    else
      render :edit
    end
  end

  # DELETE /clients/1
  def destroy
    if @client.destroy
      redirect_to clients_url, success: '客户已删除'
    else
      redirect_back fallback_location: clients_url, alert: '客户删除失败'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_params
      params.fetch(:client, {}).permit(helpers.fields, %i[manager_id manager_type], contact_attributes: helpers.contact_fields)
    end
end
