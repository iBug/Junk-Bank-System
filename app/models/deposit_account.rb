class DepositAccount < ApplicationRecord
  set_display_name '储蓄账户'

  has_one :account, as: :accountable
end
