class StatsController < ApplicationController
  # GET /
  def home
    @cards = [Branch, Department, Staff, Client, Account, Loan].zip \
      %w[dollar-square department manager user credit-card debt]
  end

  # GET /stats
  def index
    @branches_count = Branch.count
    @accounts_count, @accounts_amount = Account.pluck('COUNT(id)', 'SUM(balance)').first
    @deposit_accounts_count = Account.where(accountable_type: :DepositAccount).size
    Account.group(:accountable_type).select('COUNT(id)', :accountable_type)
    @check_accounts_count = Account.where(accountable_type: :CheckAccount).size
    @loans_count, @loans_amount = Loan.pluck('COUNT(id)', 'SUM(amount)').first
    loan_statuses = Loan.left_outer_joins(:issues).group(:id).select(:id, %[
      CASE
        WHEN IFNULL(SUM(issues.amount), 0) = 0 THEN 0
        WHEN SUM(issues.amount) = loans.amount THEN 2
        ELSE 1
      END AS status
    ].squish)
    Loan.from(loan_statuses, :statuses).group(:status).select('COUNT(id) AS count', :status).each do |row|
      case row.status
      when 0
        @unissued = row.count
      when 2
        @issued = row.count
      else
        @issuing = row.count
      end
    end

    @deposit_card_content = %w[支行 账户 总金额 储蓄账户 支票账户].zip [
      @branches_count, @accounts_count, helpers.currency_value(@accounts_amount),
      @deposit_accounts_count, @check_accounts_count,
    ]
    @loan_card_content = %w[支行 贷款 总金额 未发放 发放中 已发放].zip [
      @branches_count, @loans_count, helpers.currency_value(@loans_amount),
      (@unissued ||= 0), (@issuing ||= 0), (@issued ||= 0),
    ]
  end

  # GET /stats/deposit
  def deposit
    @action = search_params[:action]
  end

  # GET /stats/loan
  def loan
  end

  private

  def search_params
    @url_params ||= request.GET
  end
end
