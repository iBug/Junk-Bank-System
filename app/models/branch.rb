class Branch < ApplicationRecord
  has_many :staffs, dependent: :restrict_with_error
  has_many :ownerships, dependent: :restrict_with_error
  has_many :accounts, through: :ownerships
  has_many :loans, dependent: :restrict_with_error

  validates_uniqueness_of :name
  validates_presence_of :city
  validates_numericality_of :assets, greater_than_or_equal_to: 0.0
end
