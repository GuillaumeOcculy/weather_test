# Docs: https://developer.accuweather.com/apis

class AccuWeatherApi
  include HTTParty
  base_uri "http://dataservice.accuweather.com"
  ACCU_WEATHER_API_KEY = ENV.fetch("ACCU_WEATHER_API_KEY")

  def self.get_location_key(location)
    response = get("/locations/v1/cities/search", query: {apikey: ACCU_WEATHER_API_KEY, q: location})
    response.first["Key"]
  end

  def self.get_forecast_five_days(location_key)
    response = get("/forecasts/v1/daily/5day/#{location_key}", query: {apikey: ACCU_WEATHER_API_KEY, metric: true})
    response["DailyForecasts"]
  end
end
