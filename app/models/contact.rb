class Contact < ApplicationRecord
  belongs_to :client

  validates :name, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :relationship, presence: true
end
