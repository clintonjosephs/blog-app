require 'swagger_helper'

describe 'Users API' do
    path '/api/v1/users/login' do
        post 'Authentication to get jwt token' do
            tags 'User'
            consumes 'application/json'
            parameter name: :params, in: :body, schema: {
                type: :object,
                properties: {
                    email: { type: :string },
                    password: { type: :string }
                },
                required: [ 'email', 'password' ]   
            }
            response '200', 'Login Successful' do
                @user = FactoryBot.create(:user)
                email = @user.email
                let(:params) { { email: email, password: 'secret' } }
                run_test! do |response|
                    data = JSON.parse(response.body)
                    expect(data['token']).not_to be_empty
                end
            end

            response '401', 'Unauthorized' do
                let(:params) { { email: 'johndoe@gmail.com', password: 'sample' } }
                run_test! 
            end
        end
    end

    path '/api/v1/users' do
        get 'List of all users' do
            tags 'User'
            consumes 'application/json'
            security [ JWT: {} ]
            response '200', 'Users list' do
              let(:'Authorization') { "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxNjA5LCJleHAiOjE2NTI1NDEzMDB9.bfgTvKFdiOEx1NvPgjSlBl23mf0zqjrQDSxSVleXeZ4" }
              run_test! do |response|
                data = JSON.parse(response.body)
                expect(data.length).to be > 0
              end
            end

            response '401', 'Users list' do
               let(:'Authorization') { "" }
               run_test!
             end
        end
    end
end