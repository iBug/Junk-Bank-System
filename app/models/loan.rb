class Loan < ApplicationRecord
  belongs_to :branch
  has_and_belongs_to_many :clients
  has_many :issues

  validates_presence_of :clients
  validates_numericality_of :amount, greater_than: 0.0

  before_destroy :check_issuing

  def check_issuing
    if status == :issuing
      errors.add :base, '发放中的贷款不允许删除'
      throw :abort
    end
  end

  def status
    if issues.empty?
      :unissued
    elsif issues.sum(:amount) == amount
      :issued
    else
      :issuing
    end
  end

  def remaining
    @remaining ||= issues.sum(:amount)
  end

  def reset_remaining
    @remaining = nil
  end
end
