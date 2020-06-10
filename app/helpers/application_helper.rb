module ApplicationHelper
  def site_name
    Rails.configuration.site_name.to_s
  end

  def active_page(page)
    'active' if current_page? page
  end

  def boolean_s(bool)
    bool ? '是' : '否'
  end
end
