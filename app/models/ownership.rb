class Ownership < ApplicationRecord
  set_display_name '客户账户关系'

  belongs_to :branch
  belongs_to :client
  belongs_to :account

  before_save :update_access_time

  def update_access_time
    self.last_access = Time.now
  end
end
