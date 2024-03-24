require 'swagger_helper'

describe 'Session API' do
  path '/api/v1/sessions' do

    post 'Creates a session' do
      tags 'Sessions'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, format: 'email' },
          password: { type: :string }
        },
        required: ['email', 'password']
      }

      before do
        User.create!(email: 'user@example.com', password: 'password')
      end

      response '200', 'session created' do
        let(:user) { { email: 'user@example.com', password: 'password' } }
        run_test!
      end

      response '401', 'wrong credentials' do
        let(:user) { { email: 'user@example.com', password: 'wrongpassword' } }
        run_test!
      end
    end
  end
end
