class LoansController < ApplicationController
  include LoansHelper

  before_action :set_loan, only: %i[show issues clients add_client destroy_client destroy]
  before_action :set_issues, only: %i[issues]

  # GET /loans
  def index
    #client_count = Loan.joins(:clients).select('COUNT(*)')
    @loans = Loan.left_outer_joins(:branch, :issues).group(:id).order(:id).select('loans.*', 'branches.name AS branch_name', 'IFNULL(SUM(issues.amount), 0) AS amount_issued')
  end

  # GET /loans/1
  def show
    @clients = Client.joins(:loans).where('clients_loans.loan_id = ?', @loan.id)
  end

  # GET /loans/1/issues
  def issues
    @issue = Issue.new
  end

  # GET /loans/1/clients
  def clients
  end

  # GET /loans/new
  def new
    @loan = Loan.new
  end

  # POST /loans
  def create
    @loan = Loan.new(loan_params)

    if @loan.save
      redirect_to @loan, success: '成功创建贷款'
    else
      render :new
    end
  end

  # DELETE /loans/1
  def destroy
    @loan.destroy
    redirect_to loans_url, success: '成功删除贷款'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      id = params[:id]
      @loan = Loan.left_outer_joins(:branch, :issues).group(:id).select('loans.*', 'branches.name AS branch_name', 'IFNULL(SUM(issues.amount), 0.0) AS amount_issued', 'loans.amount - IFNULL(SUM(issues.amount), 0.0) AS remaining').find(id)
      @clients = Loan.left_outer_joins(:clients).where('loans.id = ?', id)
      @status = status_of @loan
    end

    def set_issues
      @issues = @loan.issues.order(date: :asc, id: :asc).all
    end

    # Only allow a list of trusted parameters through.
    def loan_params
      params.require(:loan).permit(%i[branch_id amount], client_ids: [])
    end
end
