module ClientsHelper
  include AccountsHelper

  MANAGER_TYPE_NAMES = %w[未指定 贷款负责人 银行账户负责人 同时为贷款负责人和银行账户负责人]
  MANAGER_TYPE_NAMES_SHORT = %w[未指定 贷款 银行账户 贷款+银行账户]

  private_constant :MANAGER_TYPE_NAMES, :MANAGER_TYPE_NAMES_SHORT

  def contact_fields
    ContactsHelper::fields
  end

  def contact_fields_with_name
    ContactsHelper::fields_with_name
  end

  def manager_type_name(manager_type)
    MANAGER_TYPE_NAMES[manager_type]
  rescue
    return 'Invalid value'
  end

  def manager_type_name_short(manager_type)
    MANAGER_TYPE_NAMES_SHORT[manager_type]
  rescue
    return 'Invalid value'
  end

  def manager_types_with_name
    MANAGER_TYPE_NAMES.each_with_index.to_a
  end
end
