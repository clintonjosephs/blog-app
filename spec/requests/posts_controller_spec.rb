require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
    before(:example) { get('/users/1/posts') } # get(:index)

    it 'successfully gets list of posts for a particular user' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text' do
      expect(response.body).to include 'Posts'
    end
  end

  describe 'GET #show' do
    before(:example) { get('/users/1/posts/2') } # get(:show, params: { id: 1 })

    it 'successfully gets details of post 10 from user 11' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text' do
      expect(response.body).to include 'Post'
    end
  end
end
