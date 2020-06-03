class Client < Person
  belongs_to :manager, class_name: :Staff
  has_one :contact, dependent: :destroy
  accepts_nested_attributes_for :contact
  has_many :created_deposit_accounts
  has_many :created_check_accounts
  has_and_belongs_to_many :loans
end
