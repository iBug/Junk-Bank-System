class Ownership < ApplicationRecord
  belongs_to :branch
  belongs_to :client
  belongs_to :account

  validates_uniqueness_of :client, scope: %i[branch accountable_type]

  before_save :update_access_time
  before_destroy :check_owners_count

  def update_access_time
    self.last_access = Time.now
  end

  def check_owners_count
    return if account.ownerships.count > 1
    errors.add :base, '关联客户至少有一位'
    throw :abort
  end
end
