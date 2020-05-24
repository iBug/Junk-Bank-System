class Staff < ApplicationRecord
  belongs_to :branch
  belongs_to :department
end
