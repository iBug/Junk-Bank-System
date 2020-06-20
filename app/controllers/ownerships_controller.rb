class OwnershipsController < ApplicationController
  before_action :set_account, only: %i[create destroy]
  before_action :set_ownership, only: %i[destroy]

  # POST /accounts/1/owners
  def create
    owner = Ownership.new ownership_params

    if owner.save
      redirect_to account_owners_url(@account), success: '成功为账户添加客户'
    else
      render 'accounts/owners'
    end
  end

  # DELETE /accounts/1/owners
  def destroy
    if @ownership.destroy
      redirect_to account_owners_url(@account), success: '客户已从账户删除'
    else
      redirect_to account_owners_url(@account), alert: '客户从账户删除失败'
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
