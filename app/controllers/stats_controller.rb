class StatsController < ApplicationController
  before_action :set_form, only: %i[deposit loan]

  # GET /
  def home
    @cards = [Branch, Department, Staff, Client, Account, Loan].zip \
      %w[safe department manager user credit-card debt]
  end

  # GET /stats
  def index
    @branches_count = Branch.count
    @accounts_count, @accounts_amount = Account.pluck('COUNT(id)', 'SUM(balance)').first
    Account.group(:accountable_type).pluck('COUNT(id)', :accountable_type).each do |count, type|
      @deposit_accounts_count = count if type == 'DepositAccount'
      @check_accounts_count = count if type == 'CheckAccount'
    end
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
      (@deposit_accounts_count ||= 0), (@check_accounts_count ||= 0),
    ]
    @loan_card_content = %w[支行 贷款 总金额 未发放 发放中 已发放].zip [
      @branches_count, @loans_count, helpers.currency_value(@loans_amount),
      (@unissued ||= 0), (@issuing ||= 0), (@issued ||= 0),
    ]
  end

  # GET /stats/deposit
  def deposit
  end

  # GET /stats/loan
  def loan
  end

  private

  def search_params
    @url_params ||= request.GET
  end

  def set_form
    @action = search_params[:action]
    @branches = (p search_params[:branch] || '').split(' ').map(&:to_i)
    @start_year = Account.order(open_date: :asc).select(:open_date).first.open_date.year
    @end_year = Date.today.year
    @date_options = {
      date_separator: '</div><div class="col col-4">',
      start_year: @start_year,
      end_year: @end_year,
    }
    @start_date = Date.parse search_params[:start_date] rescue 7.days.ago
    @end_date = Date.parse search_params[:end_date] rescue Date.today
    @time_spans = %w[无 月 季度 年].zip %i[none month quarter year]
    @time_span = (search_params[:time_span] || :none).to_sym
  end
end
