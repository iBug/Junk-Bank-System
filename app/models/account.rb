class Account < ApplicationRecord
  set_display_name '账户'

  belongs_to :branch
  belongs_to :client
  belongs_to :accountable, polymorphic: true

  accepts_nested_attributes_for :accountable

  before_save :update_access_time

  # Credits: https://stackoverflow.com/a/32915379/5958455
  def build_accountable(params)
    self.accountable = accountable_type.safe_constantize.new params
  end

  def update_access_time
    update_attribute :last_access, Time.now
  end
end
