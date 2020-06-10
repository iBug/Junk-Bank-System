class Branch < ApplicationRecord
  has_many :staffs
  has_many :created_deposit_accounts
  has_many :created_check_accounts

  def display_name
    '支行'
  end
end
