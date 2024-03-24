require "accu_weather_api"

class GetOrCreateForecastService < ApplicationService
  validates :location, presence: true

  attr_reader :location
  attr_accessor :city, :forecast

  def initialize(location)
    @location = location
  end

  def call
    validate
    find_or_create_city
    find_or_create_forecast

  rescue StandardError => e
    fail!(e.message)
  end

  private

  def find_or_create_city
    city_service = GetOrCreateCityService.call(location)
    self.city = city_service.city

    fail!("City not found") unless city
  end

  def find_or_create_forecast
    return if error?

    date = Date.today
    self.forecast = Forecast.find_or_create_by(city: city, date: date) do |forecast|
      forecast.city = city
      forecast.date = date
      forecast.response = AccuWeatherApi.get_forecast_five_days(city.accu_weather_key)
    end
  end
end
