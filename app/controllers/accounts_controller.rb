class AccountsController < ApplicationController
  before_action :set_account, only: %i[show edit owners owner_create update destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.joins(:branch).select('accounts.*', 'branches.name AS branch_name')
  end

  # GET /accounts/1
  # GET /accounts/1.json
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
    @available_clients = Client.where.not(id: Ownership.where(account: @account, accountable_type: @account.accountable_type).select(:client_id)).select(:id, :name)
  end

  # POST /accounts/1/owners
  def owner_create
    owner = Ownership.new ownership_params

    respond_to do |format|
      if owner.save
        format.html { redirect_to account_owners_url(@account), notice: 'Owner was successfully added.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /accounts
  # POST /accounts.json
  def create
    params = account_params
    accountable_type = params[:accountable_type]
    @typed_account = accountable_type.safe_constantize.new(params[:accountable_attributes])
    # Insert account and branch info into ownership
    params[:ownerships_attributes]&.each_value do |attr|
      attr.merge!(accountable_type: accountable_type, branch_id: params[:branch_id])
    end
    @account = @typed_account.build_account(params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(update_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
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
      account_params.except(*%i[branch_id accountable_type ownerships_attributes])
    end

    def ownership_params
      params.require(:ownerships).permit(:client_id).merge(account: @account, accountable_type: @account.accountable_type, branch: @account.branch)
    end
end
