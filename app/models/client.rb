class Client < Person
  belongs_to :manager, class_name: :Staff
  has_one :contact, dependent: :destroy
  has_many :ownerships, dependent: :restrict_with_error
  has_and_belongs_to_many :accounts, through: :ownerships
  has_and_belongs_to_many :loans, dependent: :restrict_with_error

  accepts_nested_attributes_for :contact, update_only: true, allow_destroy: true
end
