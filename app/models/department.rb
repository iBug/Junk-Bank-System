class Department < ApplicationRecord
  set_display_name '部门'

  has_many :staffs

  validates :name, presence: true
  validates :kind, presence: true
end
