class AccountsController < ApplicationController
  before_action :set_account, only: %i[show edit owners owner_create update destroy]

  # GET /accounts
  def index
    @accounts = Account.joins(:branch).order(:id).select('accounts.*', 'branches.name AS branch_name')
  end

  # GET /accounts/1
  def show
    @owners = @account.ownerships.joins(:client).limit(3).select(:client_id, 'clients.name AS client_name')
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # GET /accounts/1/owners
  def owners
    @ownership = Ownership.new
    @owners = @account.ownerships.joins(:client).select(:client_id, 'clients.name AS client_name')
    @available_clients = Client.where.not(id: Ownership.where(branch_id: @account.branch_id, accountable_type: @account.accountable_type).select(:client_id)).select(:id, :name)
  end

  # POST /accounts
  def create
    params = account_params
    accountable_type = params[:accountable_type]
    @typed_account = accountable_type.safe_constantize.new(params[:accountable_attributes])
    # Insert account and branch info into ownership
    params[:ownerships_attributes]&.each_value do |attr|
      attr.merge!(accountable_type: accountable_type, branch_id: params[:branch_id])
    end
    @account = @typed_account.build_account(params)

    if @account.save
      redirect_to @account, success: '成功创建账户'
    else
      render :new
    end
  end

  # PATCH/PUT /accounts/1
  def update
    Account.transaction do
      Ownership.where(account: @account).update_all(branch_id: update_params[:branch_id])
      @account.update! update_params
    end
    redirect_to @account, success: '成功更新账户'
  rescue ActiveRecord::ActiveRecordError
    render :edit, alert: '账户更新失败'
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy
    redirect_to accounts_url, success: '账户已销户'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.joins(:branch, :ownerships).group(:id).select('accounts.*', 'branches.name AS branch_name', 'COUNT(ownerships.client_id) AS owners_count').find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(%i[id branch_id accountable_type balance open_date], accountable_attributes: %i[interest_rate currency withdraw_amount], ownerships_attributes: %i[client_id])
    end

    def update_params
      account_params.except(*%i[accountable_type ownerships_attributes])
    end

    def ownership_params
      params.require(:ownerships).permit(:client_id).merge(account: @account, accountable_type: @account.accountable_type, branch: @account.branch)
    end
end
