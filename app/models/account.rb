class Account < ApplicationRecord
  set_display_name '账户'

  belongs_to :branch
  belongs_to :client
  has_one :deposit_account, as: :accountable, polymorphic: true
  has_one :check_account, as: :accountable, polymorphic: true
end
