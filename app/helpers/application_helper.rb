module ApplicationHelper
  def active_page(page)
    current_page?(page) ? 'active' : ''
  end

  def boolean_s(bool)
    bool ? '是' : '否'
  end

  def navbar_models
    [Branch, Department, Staff, Client, Account].zip %w[university building user-tie user-friends user-circle]
  end

  def site_name
    Rails.configuration.site_name.to_s
  end
end
