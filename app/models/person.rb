class Person < ApplicationRecord
  self.abstract_class = true

  validates_uniqueness_of :person_id
  validate :valid_person_id?
  validates :name, presence: true
  validates :phone, presence: true
  validates :address, presence: true

  def valid_person_id?
    # errors.add :person_id, 'Invalid personal ID' unless person_id =~ %r![0-9]{17}[0-9xX]!
  end
end
