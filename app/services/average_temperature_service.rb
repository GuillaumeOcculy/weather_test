class AverageTemperatureService < ApplicationService
  attr_reader :city_names
  attr_accessor :average_temperature

  validates :city_names, presence: true
  validate :validate_city_names_are_included

  def initialize(city_names)
    @city_names = city_names.split(',').map(&:strip).map(&:downcase)
  end

  def call
    validate

    find_average_temperature
  rescue StandardError => e
    fail!(e.message)
  end

  private

  def find_average_temperature
    return if error?

    city_names.each do |city_name|
      GetOrCreateForecastService.call(city_name)
    end

    forecasts = Forecast.where(city: City.where(name: city_names), date: Date.today)

    @average_temperature = forecasts.average_temperature.to_f.round(2)
  end

  def validate_city_names_are_included
    city_names.each do |city_name|
      errors.add(:city_names, "#{city_name} is not included in the list") unless City::NAMES.include?(city_name.capitalize)
    end
  end
end
