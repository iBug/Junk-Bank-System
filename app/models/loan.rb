class Loan < ApplicationRecord
  set_display_name '贷款'

  belongs_to :branch
  has_and_belongs_to_many :clients
  has_many :issues

  validates_presence_of :clients
  validates_numericality_of :amount, greater_than: 0.0

  scope :unissued, -> { includes(:issues).where(issues: { loan_id: nil }) }
  # Rails 6.1: unissued = where.missing(:issues)
  scope :issued, -> { joins(:issues).group(:id).having('SUM(issues.amount) = amount') }
  scope :issuing, -> { where.not(id: unissued).where.not(id: issued) }

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
