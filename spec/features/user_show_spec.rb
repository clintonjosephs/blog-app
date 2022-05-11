require 'rails_helper'

RSpec.describe 'User show features' do
  before(:each) do
    User.destroy_all
    Post.destroy_all
    @user = FactoryBot.create(:user, PostsCounter: 2)
    m = 5
    while m > 0
      FactoryBot.create(:post, user_id: @user.id)
      m -= 1
    end
    route_user = User.first
    visit(user_path(route_user.id))
  end

  scenario 'Confirm that user is on the user show page' do
    user = User.first
    expect(page).to have_content("#{user.Name}'s details")
  end

  scenario "Confirm that user's profile picture shows on the page" do
    user = User.first
    expect(page).to have_css("img[src*='#{user.Photo}']")
  end

  scenario "Confirm that user's number of posts is showing on the page" do
    user = User.includes(:posts).first
    expect(page).to have_content("Number of posts: #{user.posts.count}")
  end

  scenario 'Confirm that I can see the users bio' do
    user = User.first
    expect(page).to have_content(user.Bio.to_s)
  end

  scenario 'Confirm that I can see the users first 3 posts' do
    expect(page).to have_content('Recent Posts')
    expect(page).to have_css('li.shadow', count: 3)
  end

  scenario 'Confirm that there is a button to see the rest of the posts' do
    expect(page).to have_link('See all posts')
  end

  scenario "Confirm that when I click the button to see the rest of the posts,
            I am redirected to the user's posts page" do
    user = User.first
    click_on 'See all posts'
    expect(page).to have_current_path(user_posts_path(user.id))
  end

  scenario "Confirm that when I click a user's post, I am redirected to the post show page" do
    user = User.first
    click_on user.posts.last.Title
    expect(page).to have_current_path(user_post_path(user.id, user.posts.last.id))
  end
end
