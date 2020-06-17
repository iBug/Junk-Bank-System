class Account < ApplicationRecord
  set_display_name '账户'

  belongs_to :branch
  belongs_to :accountable, polymorphic: true
  has_and_belongs_to_many :clients, through: :ownerships

  accepts_nested_attributes_for :accountable, :clients

  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validate :has_clients

  # Credits: https://stackoverflow.com/a/32915379/5958455
  def build_accountable(params)
    self.accountable = accountable_type.safe_constantize.new params
  end

  def has_clients
    errors.add :base, 'Requires at least one client' if clients.empty?
  end
end
