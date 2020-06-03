module PersonsHelper
  def fields
    %w{person_id name phone address}.map(&:to_sym)
  end
end
