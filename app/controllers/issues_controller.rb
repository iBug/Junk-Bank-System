class IssuesController < ApplicationController
  before_action :set_loan, only: %i[create]

  # POST /loans/1/issues
  def create
    @issue = Issue.new issue_params

    if @issue.save
      redirect_to loan_issues_url(@loan), success: '成功添加支付'
    else
      render 'loans/issues'
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
