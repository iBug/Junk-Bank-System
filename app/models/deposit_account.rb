class DepositAccount < ApplicationRecord
  include Accountable

  validates_numericality_of :interest_rate, greater_than_or_equal_to: 0.0
end
