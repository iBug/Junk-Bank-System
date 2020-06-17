class IssuesController < ApplicationController
  before_action :set_loan, only: %i[create]

  # POST /loans/1/issues
  # POST /loans/1/issues.json
  def create
    @issue = Issue.new issue_params

    respond_to do |format|
      if @issue.save
        format.html { redirect_to loan_issues_url(@loan), notice: 'Issue was successfully added.' }
        format.json { render :show, status: :created, location: loan_issues_url(@loan) }
      else
        #format.html { redirect_to loan_issues_url(@loan) }
        format.html { render 'loans/issues' }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      @loan = Loan.find(params[:id])
    end

    def issue_params
      params.require(:issues).permit(%i[date amount]).merge(loan: @loan)
    end
end
