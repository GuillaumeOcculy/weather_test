require 'swagger_helper'

describe 'Users API' do
  path '/api/v1/users' do
    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, format: 'email', example: 'user@example.com' },
          password: { type: :string, format: 'password', example: 'password' },
          prefered_city: { type: :string, example: 'Paris' }
        },
        required: ['email', 'password']
      }

      response '201', 'user created' do
        let(:user) { { email: 'user@example.com', password: 'password', prefered_city: 'Paris' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { email: 'user@example.com' } } # Missing password
        run_test!
      end
    end
  end
end
