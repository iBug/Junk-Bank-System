class Department < ApplicationRecord
  has_many :staffs

  validates :name, presence: true
  validates :kind, presence: true
end
