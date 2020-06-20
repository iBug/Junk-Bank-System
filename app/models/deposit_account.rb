class DepositAccount < ApplicationRecord
  include Accountable

  validates :interest_rate, numericality: { greater_than_or_equal_to: 0.0 }
end
