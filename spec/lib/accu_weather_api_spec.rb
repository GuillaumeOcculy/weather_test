require "rails_helper"
require "accu_weather_api"

RSpec.describe AccuWeatherApi do

  before do
    stub_request(:get, "http://dataservice.accuweather.com/#{path}")
      .with(query: { apikey: ENV["ACCU_WEATHER_API_KEY"]}.merge(query))
      .to_return(status: 200, body: response, headers: { "Content-Type" => "application/json" })
  end

  describe ".get_location_key" do
    let(:path) { "locations/v1/cities/search" }
    let(:response) { Rails.root.join("spec/fixtures/accu_weather/locations.json").read }
    let(:city) { "Paris" }
    let(:query) { { q: city } }

    subject { described_class.get_location_key(city) }

    before do
      stub_request(:get, "http://dataservice.accuweather.com/locations/v1/cities/search")
      .with(query: {apikey: ENV["ACCU_WEATHER_API_KEY"], q: city})
      .to_return(status: 200, body: response, headers: { "Content-Type" => "application/json" })
    end

    it { is_expected.to eq("623") }
  end

  describe ".get_forecast_five_days" do
    let(:path) { "forecasts/v1/daily/5day/#{location_key}" }
    let(:response) { Rails.root.join("spec/fixtures/accu_weather/forecasts.json").read }
    let(:location_key) { "123" }
    let(:query) { { metric: true } }
    subject { described_class.get_forecast_five_days(location_key) }

    it { expect(subject).to be_an(Array) }
    it { expect(subject[0].keys).to eq(["Date", "EpochDate", "Temperature", "Day", "Night", "Sources", "MobileLink", "Link"]) }
  end
end
