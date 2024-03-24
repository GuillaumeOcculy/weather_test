class GetOrCreateCityService < ApplicationService
  validates :name, presence: true

  attr_reader :name
  attr_accessor :city

  def initialize(name)
    @name = name
  end

  def call
    find_or_create_city
  rescue StandardError => e
    fail!(e.message)
  end

  private

  def find_or_create_city
    self.city = City.find_or_create_by(name: name) do |city|
      city.accu_weather_key = AccuWeatherApi.get_location_key(name)
    end
  end
end
