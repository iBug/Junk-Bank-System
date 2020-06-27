class Person < ApplicationRecord
  self.abstract_class = true

  validates_uniqueness_of :person_id
  #validate :valid_person_id?
  validates_presence_of :name
  validates_presence_of :phone
  validates_presence_of :address

  def valid_person_id?
    errors.add :person_id, 'Invalid personal ID' unless person_id =~ %r![0-9]{17}[0-9xX]!
  end
end
