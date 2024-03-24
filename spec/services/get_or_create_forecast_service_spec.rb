require 'rails_helper'

RSpec.describe GetOrCreateForecastService do
  describe '.call' do
    let(:location) { "paris" }
    let(:date) { Date.today }

    context 'when city and forecast already exist' do
      let!(:city) { create(:city, name: location) }
      let!(:forecast) { create(:forecast, city: city, date: date) }

      it 'does not create a new city' do
        expect { described_class.call(location, date) }.not_to change(City, :count)
      end

      it 'does not create a new forecast' do
        expect { described_class.call(location, date) }.not_to change(Forecast, :count)
      end
    end

    context 'when city exists but forecast does not' do
      let!(:city) { create(:city, name: location) }

      before do
        allow(AccuWeatherApi).to receive(:get_forecast_five_days).and_return([{ "Date" => date.to_s, "Temperature" => { "Minimum" => { "Value" => 10, "Unit" => "C" }, "Maximum" => { "Value" => 20 } } }])
      end

      it 'creates a new forecast' do
        expect { described_class.call(location, date) }.to change(Forecast, :count).by(1)
      end
    end

    context 'when city does not exist' do
      before do
        allow(AccuWeatherApi).to receive(:get_location_key).with(location).and_return('123')
        allow(AccuWeatherApi).to receive(:get_forecast_five_days).and_return([{ "Date" => date.to_s, "Temperature" => { "Minimum" => { "Value" => 10, "Unit" => "C" }, "Maximum" => { "Value" => 20 } } }])
      end

      it 'creates a new city and forecast' do
        expect { described_class.call(location, date) }.to change(City, :count).by(1).and change(Forecast, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'fails if location is missing' do
        service = described_class.call(nil, date)
        expect(service.error?).to be true
      end
    end

    context 'when forecast is found' do
      let!(:city) { create(:city, name: location) }
      let!(:forecast) { create(:forecast, city: city, date: date) }

      it 'returns the forecast' do
        service = described_class.call(location, date)
        expect(service.forecast).to eq forecast
      end
    end
  end
end
