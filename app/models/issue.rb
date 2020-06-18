class Issue < ApplicationRecord
  set_display_name '支付'
  belongs_to :loan

  validates_numericality_of :amount, greater_than: 0.0
  validate :check_amount, on: :create

  def check_amount
    if amount > loan.remaining
      errors.add :base, 'Cannot issue more than remaining amount'
    else
      loan.reset_remaining
    end
  end
end
