module ApplicationHelper
  def site_name
    Rails.configuration.site_name.to_s
  end
end
