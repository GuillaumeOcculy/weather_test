require 'rails_helper'

RSpec.describe AverageTemperatureService do
  describe '.call' do
    context 'with valid city names' do
      let(:city_names) { 'paris,london,tokyo' }

      before do
        ['paris', 'london', 'tokyo'].each do |city_name|
          city = create(:city, name: city_name)
          create(:forecast, city: city)
        end
      end

      it 'calculates the average temperature for the cities' do
        service = described_class.call(city_names)

        expect(service.success?).to be true
        expect(service.average_temperature).to eq(10.0)
        expect(service.city_names).to eq(['paris', 'london', 'tokyo'])
      end
    end

    context 'with invalid city names' do
      let(:city_names) { 'berlin,paris' }

      it 'fails and adds an error message for each invalid city' do
        service = described_class.call(city_names)
        expect(service.error?).to be true
        expect(service.error_messages).to include('berlin is not included in the list')
      end
    end

    context 'when city names are empty' do
      let(:city_names) { '' }

      it 'fails and adds an error message' do
        service = described_class.call(city_names)
        expect(service.error?).to be true
        expect(service.error_messages).to eq("City names can't be blank")
      end
    end
  end
end
