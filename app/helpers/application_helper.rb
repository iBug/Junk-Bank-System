module ApplicationHelper
  def site_name
    Rails.configuration.site_name.to_s
  end

  def active_page(page)
    'active' if current_page? page
  end
end
