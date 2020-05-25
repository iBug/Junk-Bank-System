class Client < ApplicationRecord
  belongs_to :manager, class_name: "Staff"
  has_one :contact
end
