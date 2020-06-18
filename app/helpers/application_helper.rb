module ApplicationHelper
  def active_page(page)
    current_page?(page) ? 'active' : ''
  end

  def boolean_s(bool)
    bool ? '是' : '否'
  end

  def navbar_models
    [Branch, Department, Staff, Client, Account, Loan].zip %w[university building user-tie user-friends user-circle money-bill-alt]
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
end
