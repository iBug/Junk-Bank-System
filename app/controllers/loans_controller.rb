class LoansController < ApplicationController
  include LoansHelper

  before_action :set_loan, only: %i[show issues clients add_client destroy_client destroy]
  before_action :set_issues, only: %i[issues]

  # GET /loans
  # GET /loans.json
  def index
    #client_count = Loan.joins(:clients).select('COUNT(*)')
    @loans = Loan.left_outer_joins(:branch, :issues).group(:id).select('loans.*', 'branches.name AS branch_name', 'IFNULL(SUM(issues.amount), 0) AS amount_issued')
  end

  # GET /loans/1
  # GET /loans/1.json
  def show
    @clients = Loan.joins(:clients).limit(3).select(:client_id, 'clients.name AS client_name')
    @status = status_of @loan
  end

  # GET /loans/1/issues
  # GET /loans/1/issues.json
  def issues
    @issue = Issue.new
    @status = status_of @loan
  end

  # GET /loans/1/clients
  # GET /loans/1/clients.json
  def clients
  end

  # GET /loans/new
  def new
    @loan = Loan.new
  end

  # POST /loans
  # POST /loans.json
  def create
    @loan = Loan.new(loan_params)

    respond_to do |format|
      if @loan.save
        format.html { redirect_to @loan, notice: 'Loan was successfully created.' }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { render :new }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loans/1
  # DELETE /loans/1.json
  def destroy
    @loan.destroy
    respond_to do |format|
      format.html { redirect_to loans_url, notice: 'Loan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      id = params[:id]
      @loan = Loan.left_outer_joins(:branch, :issues).group(:id).select('loans.*', 'branches.name AS branch_name', 'IFNULL(SUM(issues.amount), 0.0) AS amount_issued', 'loans.amount - IFNULL(SUM(issues.amount), 0.0) AS remaining').find(id)
      @clients = Loan.left_outer_joins(:clients).where('loans.id = ?', id)
    end

    def set_issues
      @issues = @loan.issues.order(date: :asc, id: :asc).all
    end

    # Only allow a list of trusted parameters through.
    def loan_params
      params.require(:loan).permit(%i[branch_id amount], client_ids: [])
    end
end
