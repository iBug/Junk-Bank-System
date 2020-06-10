module PersonsHelper
  FIELDS = %i[name person_id phone address]
  NAMES = %w[姓名 身份证号 电话 地址]

  private_constant :FIELDS, :NAMES

  def fields
    FIELDS
  end

  def fields_with_name
    FIELDS.zip NAMES
  end
end
