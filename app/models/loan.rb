class Loan < ApplicationRecord
  set_display_name '贷款'

  belongs_to :branch
  has_and_belongs_to_many :clients
  has_many :issues

  scope :unissued, -> { includes(:issues).where(issues: { loan_id: nil }) }
  # Rails 6.1: unissued = where.missing(:issues)
  scope :issued, -> { joins(:issues).group(:id).having('SUM(issues.amount) = amount') }
  scope :issuing, -> { where.not(id: unissued).where.not(id: issued) }
end
