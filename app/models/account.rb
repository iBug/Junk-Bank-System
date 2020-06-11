class Account < ApplicationRecord
  set_display_name '账户'

  belongs_to :branch
  belongs_to :client
  belongs_to :accountable, polymorphic: true

  accepts_nested_attributes_for :accountable
end
