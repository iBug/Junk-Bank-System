class Client < Person
  set_display_name '客户'

  belongs_to :manager, class_name: :Staff
  has_one :contact, dependent: :destroy
  has_and_belongs_to_many :accounts, through: :ownerships
  has_and_belongs_to_many :loans

  accepts_nested_attributes_for :contact, update_only: true, allow_destroy: true
end
