require 'swagger_helper'

describe 'Average Temperature API' do
  path '/api/v1/average_temperature' do

    get 'Retrieves the average temperature' do
      tags 'AverageTemperature'
      produces 'application/json'
      parameter name: :cities, in: :query, type: :string
      parameter name: :Authorization, in: :header, type: :string

      let(:user) { User.last }
      let(:Authorization) { "Bearer #{JsonWebToken.encode(user_id: user.id)}" }
      let(:cities) { 'paris,london,tokyo' }

      before do
        User.create!(email: 'user@example.com', password: 'password', prefered_city: 'paris')
        paris = City.create!(name: 'paris', accu_weather_key: '123')
        london = City.create!(name: 'london', accu_weather_key: '456')
        tokyo = City.create!(name: 'tokyo', accu_weather_key: '789')

        Forecast.create!(city: paris, date: Date.today, response: { "Temperature" => { "Minimum" => { "Value" => 10, "Unit" => "C" }, "Maximum" => { "Value" => 20 } } })
        Forecast.create!(city: london, date: Date.today, response: { "Temperature" => { "Minimum" => { "Value" => 5, "Unit" => "C" }, "Maximum" => { "Value" => 15 } } })
        Forecast.create!(city: tokyo, date: Date.today, response: { "Temperature" => { "Minimum" => { "Value" => 15, "Unit" => "C" }, "Maximum" => { "Value" => 25 } } })
      end

      response '200', 'average temperature retrieved' do
        schema type: :object,
          properties: {
            average_temperature: { type: :number, format: :float },
            unit: { type: :string },
            cities: { type: :array, items: { type: :string } }
          }
          
        run_test!
      end

      response '422', 'City is not included in the list' do
        let(:cities) { 'Berlin' }
      
        examples 'application/json' => {
          error: "Berlin is not included in the list"
        }
      
        run_test!
      end
      

      response '401', 'unauthorized' do
        let(:'Authorization') { 'Bearer invalid_token' }
        run_test!
      end
    end
  end
end
