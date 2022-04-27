require 'rails_helper'

RSpec.describe 'Users', type: :request do
    describe 'GET #index' do
        before(:example) { get( '/users' ) } # get(:index)

        it 'returns http success' do
            expect(response).to have_http_status(:ok)
        end

        it 'renders the index template' do
            expect(response).to render_template(:index)
        end

        it 'includes the correct placeholder text' do
            expect(response.body).to include 'Here is a page for showing list of users'
        end
    end

    describe 'GET #show' do
        before(:example) { get( '/users/15' ) } # get(:show, params: { id: 1 })

        it 'returns http success' do
            expect(response).to have_http_status(:ok)
        end

        it 'renders the index template' do
            expect(response).to render_template(:show)
        end

        it 'includes the correct placeholder text' do
            expect(response.body).to include 'Here is a page for showing user details'
        end
    end
end