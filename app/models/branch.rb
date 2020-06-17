class Branch < ApplicationRecord
  set_display_name '支行'

  has_many :staffs
  has_many :created_deposit_accounts
  has_many :created_check_accounts

  validates_uniqueness_of :name
  validates :city, presence: true
  validates :assets, numericality: { greater_than_or_equal_to: 0.0 }
end
