class Loan < ApplicationRecord
  belongs_to :branch
  has_and_belongs_to_many :clients
  has_many :issues
end
