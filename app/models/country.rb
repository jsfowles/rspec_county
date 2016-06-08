class Country < ActiveRecord::Base
  validates_presence_of :name, :population, :language

  def name_language
    "#{name} has a primary language of: #{language}"
  end
end
