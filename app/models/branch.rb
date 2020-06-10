class Branch < ApplicationRecord
  display_name '支行'
  has_many :staffs
  has_many :created_deposit_accounts
  has_many :created_check_accounts
end
