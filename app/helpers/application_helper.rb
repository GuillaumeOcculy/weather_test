module ApplicationHelper
  def city_array
    City::NAMES.map { |city| [city.capitalize, city] }
  end
end
