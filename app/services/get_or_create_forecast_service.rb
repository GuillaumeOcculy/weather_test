class GetOrCreateForecastService < ApplicationService
  validates :location, presence: true
  validates :date, presence: true

  attr_reader :location, :date
  attr_accessor :city, :forecast

  def initialize(location, date = Date.today)
    @location = location
    @date = date
  end

  def call
    validate

    find_or_create_city
    find_forecast || create_forecast
  rescue StandardError => e
    fail!(e.message)
  end

  private

  def find_or_create_city
    return if error?

    city_service = GetOrCreateCityService.call(location)
    self.city = city_service.city

    fail!("City not found") unless city
  end

  def find_forecast
    return if error?

    self.forecast = Forecast.find_by(city: city, date: date)
  end

  def create_forecast
    return if error?

    response = AccuWeatherApi.get_forecast_five_days(city.accu_weather_key)

    selected_date_forecast = response.find do |forecast|
      forecast["Date"].start_with?(date.to_s)
    end

    self.forecast = Forecast.create(
      city: city,
      date: date,
      response: selected_date_forecast
    )
  end
end
