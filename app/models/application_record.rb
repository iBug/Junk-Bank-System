class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Monkey-patching :)
  def self.display_name(name)
    self.model_name.define_singleton_method :human do
      name
    end
  end
end
