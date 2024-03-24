require 'rails_helper'

RSpec.describe GetOrCreateCityService do
  describe '.call' do
    let(:city_name) { 'paris' }

    context 'when city name is present' do
      before do
        allow(AccuWeatherApi).to receive(:get_location_key).with(city_name).and_return('123')
      end

      context 'when city does not exist' do
        it 'creates a new city with AccuWeather key' do
          expect { described_class.call(city_name) }.to change(City, :count).by(1)
          city = City.find_by(name: city_name)
          expect(city.accu_weather_key).to eq('123')
        end
      end

      context 'when city already exists' do
        let!(:existing_city) { create(:city, name: city_name, accu_weather_key: 'existing_key') }

        it 'does not create a new city' do
          expect { described_class.call(city_name) }.not_to change(City, :count)
        end

        it 'does not update existing city with new AccuWeather key' do
          described_class.call(city_name)
          expect(existing_city.reload.accu_weather_key).to eq('existing_key')
        end
      end
    end

    context 'when city name is not present' do
      let(:city_name) { nil }

      it 'fails and adds an error message' do
        result = described_class.call(city_name)
        expect(result.error?).to be true
        expect(result.error_messages).to include("Name can't be blank")
      end
    end

    context 'when an external API call fails' do
      before do
        allow(AccuWeatherApi).to receive(:get_location_key).with(city_name).and_raise(StandardError, 'API error')
      end

      it 'fails gracefully and adds an error message' do
        result = described_class.call(city_name)
        expect(result.error?).to be true
        expect(result.error_messages).to include('API error')
      end
    end
  end
end
