module Accountable
  extend ActiveSupport::Concern

  included do
    has_one :account, as: :accountable, dependent: :destroy

    accepts_nested_attributes_for :account

    validates_presence_of :account
  end
end
