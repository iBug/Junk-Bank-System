module PathHelper
  def ownership_path(ownership)
    client_path ownership.client_id
  end
end
