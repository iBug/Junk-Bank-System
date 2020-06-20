class Branch < ApplicationRecord
  has_many :staffs
  has_many :created_deposit_accounts
  has_many :created_check_accounts

  validates_uniqueness_of :name
  validates :city, presence: true
  validates_numericality_of :assets, greater_than_or_equal_to: 0.0
end
