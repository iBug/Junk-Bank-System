class Department < ApplicationRecord
  has_many :staffs

  def display_name
    '部门'
  end
end
