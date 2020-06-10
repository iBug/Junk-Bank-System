class Person < ApplicationRecord
  self.abstract_class = true

  validates_uniqueness_of :person_id

  def valid_person_id?
    @person_id =~ %r![0-9]{17}[0-9xX]!
  end
end
