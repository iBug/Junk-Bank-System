class Contact < ApplicationRecord
  belongs_to :client

  validates_presence_of :name
  validates_presence_of :phone
  validates_presence_of :email
  validates_presence_of :relationship
end
