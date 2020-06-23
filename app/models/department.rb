class Department < ApplicationRecord
  has_many :staffs, dependent: :restrict_with_error

  validates :name, presence: true
  validates :kind, presence: true
end
