class DepositAccount < ApplicationRecord
  include Accountable
  set_display_name '储蓄账户'

  validates :interest_rate, numericality: { greater_than_or_equal_to: 0.0 }
end
