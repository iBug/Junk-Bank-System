class Account < ApplicationRecord
  belongs_to :branch
  belongs_to :client
end
