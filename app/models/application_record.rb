class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.display_name
    self.to_s
  end

  protected

  # Monkey-patching :)
  def self.set_display_name(name)
    self.model_name.define_singleton_method :human do
      name
    end
    self.define_singleton_method :display_name do
      name
    end
  end
end
