module ClientsHelper
  MANAGER_TYPE_NAMES = %w[未指定 贷款负责人 银行账户负责人 同时为贷款负责人和银行账户负责人]

  private_constant :MANAGER_TYPE_NAMES

  def fields
    PersonsHelper::fields
  end

  def contact_fields
    ContactsHelper::fields
  end

  def contact_fields_with_name
    ContactsHelper::fields_with_name
  end

  def manager_types_with_name
    MANAGER_TYPE_NAMES.each_with_index.to_a
  end
end
