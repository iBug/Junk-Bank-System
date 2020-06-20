module ApplicationHelper
  def active_page(page)
    current_page?(page) ? 'active' : ''
  end

  def boolean_s(bool)
    bool ? '是' : '否'
  end

  def currency_value(value)
    '%.2f' % (value || 0.0)
  end

  def current_path
    request.path
  end

  def git_revision
    @git_revision ||= Rails.application.config.git_revision
  end

  def git_revision_short
    @git_revision_short ||= Rails.application.config.git_revision_short
  end

  def navbar_models
    [Branch, Department, Staff, Client, Account, Loan].zip %w[university building user-tie user-friends user-circle money-bill-alt]
  end

  def navbar_stats
    [stats_path, deposit_stats_path, loan_stats_path].zip %w[chart-area piggy-bank hand-holding-usd], %w[概览 储蓄业务 贷款业务]
  end

  def site_name
    Rails.configuration.site_name.to_s
  end

  def svg_tag(filename, options = {})
    options = {
      data: { svg_fallback: filename },
      class: 'svg-inline',
    }.merge options
    image_tag filename, options
  end

  def title(text)
    content_for :title, text
    text
  end
end
