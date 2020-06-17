class OwnershipsController < ApplicationController
  before_action :set_account, only: %i[create destroy]
  before_action :set_ownership, only: %i[destroy]

  # POST /accounts/1/owners
  # POST /accounts/1/owners.json
  def create
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

  # DELETE /accounts/1/owners
  # DELETE /accounts/1/owners.json
  def destroy
    respond_to do |format|
      if @ownership.destroy
        format.html { redirect_to account_owners_url(@account), notice: 'Client was successfully removed from account.' }
        format.json { head :no_content }
      else
        format.html { redirect_to account_owners_url(@account), alert: 'Failed to remove client from account.' }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    def set_ownership
      @ownership = Ownership.find_by(account_id: params[:id], client_id: params[:client_id])
    end

    def ownership_params
      params.require(:ownerships).permit(:client_id).merge(account: @account, accountable_type: @account.accountable_type, branch: @account.branch)
    end
end
