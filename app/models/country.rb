class Country < ActiveRecord::Base
  validates_presence_of :name, :population, :language

  def name_language
    "#{name} has a primary language of: #{language}"
  end

  def country_size
    formatted_pop = population.to_i
    if(formatted_pop >= 1000000)
      "Large"
    elsif(formatted_pop > 500000)
      "Medium"
    else
      "Small"
    end
  end
end
