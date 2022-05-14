require 'swagger_helper'

describe 'Posts API' do
   
  path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
    get 'List of comments for a particular user' do
      tags 'Comments'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string
      parameter name: :user_id, :in => :path, :type => :integer
      parameter name: :post_id, :in => :path, :type => :integer
      security [JWT: {}]
      response '200', 'Comments list' do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user_id: @user.id, Title: 'Sample Post', Text: 'Sample Text')
        m = 3
        while m > 0
          FactoryBot.create(:comment, user_id: @user.id, post_id: @post.id, Text: 'Sample comment by user')
          m -= 1
        end
        p = @post.id
        u = @user.id
        let(:Authorization) do
          'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxNjUwLCJleHAiOjE2NTI1NTM3NTd9.f6qq8VRXV0Vs12-DEM8go7dKa1bkooaqN7HNUMny_do'
        end
        let(:post_id) { p }
        let(:user_id) { u }
        run_test!
      end

        response '401', 'Unauthorized' do
            let(:Authorization) { '' }
            let(:post_id) { 12 }
            let(:user_id) { 4 }
            run_test!
        end
    end
  end

  path '/api/v1/users/posts/commentonpost' do
    post 'user comment on a particular post, ensure to add token as Authorization header' do
      tags 'Post Comment'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string },
          post_id: { type: :integer }
        },
        required: %w[post_id text]
      }
      security [JWT: {}]
      response '200', 'Post user comment, ensure to add token as Authorization header' do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user_id: @user.id, Title: 'Sample Post', Text: 'Sample Text')
        p = @post.id
        let(:Authorization) do
          'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxNjUwLCJleHAiOjE2NTI1NTM3NTd9.f6qq8VRXV0Vs12-DEM8go7dKa1bkooaqN7HNUMny_do'
        end
        let(:params) { { post_id: p, text: 'Sample comment to post' } }
        run_test!
      end

      response '404', 'post not found' do
        let(:Authorization) do
          'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxNjUwLCJleHAiOjE2NTI1NTM3NTd9.f6qq8VRXV0Vs12-DEM8go7dKa1bkooaqN7HNUMny_do'
        end
        let(:params) { {} }
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/posts' do
        get 'List of posts for a particular user' do
            tags 'Posts'
            produces 'application/json'
            parameter name: :Authorization, in: :header, type: :string
            parameter name: :user_id, :in => :path, :type => :integer
            security [JWT: {}]
            response '200', 'Posts list' do
                @user = FactoryBot.create(:user)
                m = 3
                while m > 0
                    @post = FactoryBot.create(:post, user_id: @user.id, Title: 'Sample Post', Text: 'Sample Text')
                    m -= 1
                end
                p = @post.id
                u = @user.id
                let(:Authorization) do
                    'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxNjUwLCJleHAiOjE2NTI1NTM3NTd9.f6qq8VRXV0Vs12-DEM8go7dKa1bkooaqN7HNUMny_do'
                end
                let(:user_id) { u }
                run_test!
            end

            response '401', 'Unauthorized' do
                let(:Authorization) do
                    ''
                end
                let(:user_id) { '12' }
                run_test!
            end
        end
    end
end
