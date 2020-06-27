class Department < ApplicationRecord
  has_many :staffs, dependent: :restrict_with_error

  validates_presence_of :name
  validates_presence_of :kind
end
