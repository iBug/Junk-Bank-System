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
    return unless @action
    wheres = {}
    selects = ['accounts.*',
               'COUNT(DISTINCT ownerships.client_id) AS clients_count',
               'SUM(balance) AS total_amount',
               'branches.name AS branch_name']
    groups = ['accounts.branch_id']
    orders = {}

    wheres[:branch_id] = @branches unless @branches.empty?

    # Apparently this is MySQL-specific
    case @time_span
    when :year
      selects << 'YEAR(open_date) AS open_year'
      selects << 'YEAR(open_date) AS display_time'
      groups << 'open_year'
      orders = { open_year: :asc, branch_id: :asc }
    when :quarter
      selects << 'YEAR(open_date) AS open_year'
      selects << '((MONTH(open_date) + 2) DIV 3) AS open_quarter'
      selects << 'CONCAT(YEAR(open_date), " Q", (MONTH(open_date) + 2) DIV 3) AS display_time'
      groups << 'open_quarter'
      orders = { open_year: :asc, open_quarter: :asc, branch_id: :asc }
    when :month
      selects << 'YEAR(open_date) AS open_year'
      selects << 'MONTH(open_date) AS open_month'
      selects << 'CONCAT(YEAR(open_date), "-", LPAD(MONTH(open_date), 2, "0")) AS display_time'
      groups << 'open_month'
      orders = { open_year: :asc, open_month: :asc, branch_id: :asc }
    else
      selects << 'open_date'
      selects << 'open_date AS display_time'
      groups << 'open_date'
      orders = { open_date: :asc, branch_id: :asc }
    end

    @query = Account.select(selects).joins(:branch).where(wheres).group(groups).order(orders)
    @data_branches = @query.except(:select, :group, :order).select('DISTINCT branch_id', 'branches.name AS branch_name').order(branch_id: :ASC)
    @query = @query.joins(:ownerships)
    @record_groups = @query.group_by(&:branch_id).sort_by { |k, v| k }
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
    @branches = (search_params[:branch] || '').split(' ').map(&:to_i)
    @start_year = Account.order(open_date: :asc).select(:open_date).first.open_date.year
    @end_year = Date.today.year
    @date_options = {
      date_separator: '</div><div class="col col-4">',
      start_year: @start_year,
      end_year: @end_year,
    }
    @start_date = Date.parse search_params[:start_date] rescue Date.today.at_beginning_of_month
    @end_date = Date.parse search_params[:end_date] rescue Date.today
    valid_time_spans = %i[none month quarter year]
    @time_spans = %w[无 月 季度 年].zip valid_time_spans
    @time_span = (search_params[:time_span] || :none).to_sym
    @time_span = :none unless valid_time_spans.include? @time_span
  end
end
