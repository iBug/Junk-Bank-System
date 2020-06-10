module ContactsHelper
  # This is not a real controller so have to do this
  extend self

  FIELDS = %i[name phone email relationship]
  NAMES = %w[姓名 电话 邮箱 与客户关系]

  private_constant :FIELDS, :NAMES

  def fields
    FIELDS
  end

  def fields_with_name
    FIELDS.zip NAMES
  end
end
