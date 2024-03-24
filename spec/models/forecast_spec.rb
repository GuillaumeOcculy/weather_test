require 'rails_helper'

RSpec.describe Forecast, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:response) }
    it { should validate_presence_of(:min_temperature) }
    it { should validate_numericality_of(:min_temperature) }
    it { should validate_presence_of(:max_temperature) }
    it { should validate_numericality_of(:max_temperature) }
    it { should validate_presence_of(:unit) }
    it { should validate_inclusion_of(:unit).in_array(['C']) }
  end  

  describe 'associations' do
    it { should belong_to(:city) }
  end

  describe 'callbacks' do
    describe '#set_attributes' do
      let(:forecast) { build(:forecast, response: { 'Temperature' => { 'Minimum' => { 'Value' => 5, 'Unit' => 'C' }, 'Maximum' => { 'Value' => 15, 'Unit' => 'C' } } }) }

      it 'sets min_temperature, max_temperature, and unit from response' do
        forecast.valid?
        expect(forecast.min_temperature).to eq(5)
        expect(forecast.max_temperature).to eq(15)
        expect(forecast.unit).to eq('C')
      end
    end
  end

  describe 'methods' do
    describe '#average_temperature' do
      it 'should return the average of a forecast' do
        forecast = create(:forecast)
        forecast.update(min_temperature: 5, max_temperature: 15)

        expect(forecast.average_temperature).to eq(10)
      end
    end

    describe '.average_temperature' do
      let(:city) { create(:city) }

      it 'should return the average of two forecasts' do
        forecast_1 = create(:forecast, city: city)
        forecast_2 = create(:forecast, city: city)

        forecast_1.update(min_temperature: 5, max_temperature: 15)
        forecast_2.update(min_temperature: 20, max_temperature: 25)

        expect(Forecast.average_temperature.to_f).to eq(16.25)
      end
    end
  end
end
