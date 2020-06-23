class Staff < Person
  belongs_to :branch
  belongs_to :department

  has_many :clients, foreign_key: :manager_id, dependent: :restrict_with_error
end
