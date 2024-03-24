require 'rails_helper'

RSpec.describe City, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:accu_weather_key) }
  end

  describe 'callbacks' do
    describe 'before_save' do
      it 'should sanitize name' do
        city = create(:city, name: 'New-york ')
        expect(city.name).to eq('new-york')
      end
    end
  end
end
