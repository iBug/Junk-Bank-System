class Loan < ApplicationRecord
  set_display_name '贷款'
  belongs_to :branch
  has_and_belongs_to_many :clients
  has_many :issues
end
