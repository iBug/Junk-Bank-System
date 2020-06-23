class Staff < Person
  belongs_to :branch
  belongs_to :department

  has_many :clients, as: :manager
end
