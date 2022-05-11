require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before(:each) do
    User.destroy_all
    m = 4
    while m > 0
      @user = FactoryBot.create(:user, PostsCounter: 2)
      FactoryBot.create(:post, user_id: @user.id)
      FactoryBot.create(:post, user_id: @user.id)
      m -= 1
    end
    @post = @user.posts.first
  end

  describe 'GET #index' do
    before(:example) { get("/users/#{@user.id}/posts") } # get(:index)

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
    before(:example) { get("/users/#{@user.id}/posts/#{@post.id}") }

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
