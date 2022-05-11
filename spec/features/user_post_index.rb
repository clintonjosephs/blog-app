require 'rails_helper'

RSpec.describe 'User post index features' do
  before(:each) do
    User.destroy_all
    Post.destroy_all
    user = FactoryBot.create(:user, PostsCounter: 1)
    post = FactoryBot.create(:post, user_id: user.id)
    FactoryBot.create(:comment, post_id: post.id, user_id: user.id)
    FactoryBot.create(:comment, post_id: post.id, user_id: user.id)
    FactoryBot.create(:comment, post_id: post.id, user_id: user.id)
    visit(user_posts_path(user.id))
  end

  scenario 'Confirm that we got to the user posts page' do
    user = User.first
    expect(page).to have_content("#{user.Name}'s Posts")
  end

  scenario 'Confirm that profile picture is on the page' do
    user = User.first
    expect(page).to have_css("img[src*='#{user.Photo}']")
  end

  scenario 'Confirm that user name is on the page' do
    user = User.first
    expect(page).to have_content(user.Name.to_s)
  end

  scenario 'Confirm that users number of posts is showing on the page' do
    user = User.includes(:posts).first
    expect(page).to have_content("Number of posts: #{user.posts.count}")
  end

  scenario 'Confirm that I can see a post title' do
    user = User.includes(:posts).first
    expect(page).to have_content(user.posts.first.Title)
  end

  scenario 'Confirm that I can see some post body' do
    user = User.includes(:posts).first
    post = if user.posts.first.Text.length < 100
             user.posts.first.Text
           else
             truncate(user.posts.first.Text,
                      length: 100, omission: '...')
           end
    expect(page).to have_content(post)
  end

  scenario 'Confirm that I can see the first comments on a post' do
    user = User.includes(:posts).first
    expect(page).to have_content(user.posts.first.comments.first.Text)
  end

  scenario 'Confirm that I can see how many comments a post has' do
    user = User.includes(:posts).first
    expect(page).to have_content("Comments: #{user.posts.first.comments.count}")
  end

  scenario 'Confirm that I can see how many likes a post has' do
    user = User.includes(:posts).first
    expect(page).to have_content("Likes: #{user.posts.first.likes.count}")
  end

  scenario 'Confirm that I can see the pagination button' do
    expect(page).to have_link('Pagination')
  end

  scenario 'Confirm that when I click a post it redirects to the post show page' do
    user = User.includes(:posts).first
    click_on user.posts.first.Text
    expect(page).to have_current_path(user_post_path(user.id, user.posts.first.id))
  end
end
