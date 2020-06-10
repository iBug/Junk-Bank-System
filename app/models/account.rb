class Account < ApplicationRecord
  set_display_name '账户'
  belongs_to :branch
  belongs_to :client
end
