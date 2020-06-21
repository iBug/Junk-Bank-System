class Issue < ApplicationRecord
  belongs_to :loan

  validates_numericality_of :amount, greater_than: 0.0
  validate :check_amount, on: :create

  def check_amount
    if amount > loan.remaining
      errors.add :base, '支付不能超出贷款总额'
    else
      loan.reset_remaining
    end
  end
end
