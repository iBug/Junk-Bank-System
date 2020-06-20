class Account < ApplicationRecord
  belongs_to :branch
  belongs_to :accountable, polymorphic: true
  has_many :ownerships
  #has_and_belongs_to_many :clients, through: :ownerships

  accepts_nested_attributes_for :accountable, :ownerships, update_only: true

  validate :check_balance
  validate :validate_owners

  # Credits: https://stackoverflow.com/a/32915379/5958455
  def build_accountable(params)
    self.accountable = accountable_type.safe_constantize.new params
  end

  def validate_owners
    errors.add :base, '关联客户至少有一位' if ownerships.empty?
  end

  def check_balance
    case accountable_type
    when 'DepositAccount'
      errors.add :base, '储蓄账户不允许欠款' if balance < 0.0
    when 'CheckAccount'
      errors.add :base, '支票账户欠款不允许超过透支额' if balance + accountable.withdraw_amount < 0.0
    end
  end
end
