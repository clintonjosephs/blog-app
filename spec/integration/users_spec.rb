require 'swagger_helper'

describe 'Users API' do
    path '/api/v1/users/login' do
        post 'login' do
            tags 'User'
            consumes 'application/json'
            parameter name: :authorization, in: :body, schema: {
                type: :object,
                properties: {
                    email: { type: :string },
                    password: { type: :string }
                },
                required: [ 'email', 'password' ]   
            }
            response '200', 'Login Successful' do
                let(:authorization) { {token: 'JWT token', exp: 'Expiry date and time', Name: 'Name of user'} }
                run_test!
            end
        end
    end
end