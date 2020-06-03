module ClientsHelper
  def fields
    PersonsHelper::fields
  end

  def contact_fields
    %i{name phone email relationship}
  end
end
