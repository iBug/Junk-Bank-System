class Account < ApplicationRecord
  set_display_name '账户'

  belongs_to :branch
  belongs_to :client
  belongs_to :deposit_account, polymorphic: true
  belongs_to :check_account, polymorphic: true

  accepts_nested_attributes_for :deposit_account, :check_account
end
