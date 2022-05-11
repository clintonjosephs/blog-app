require 'rails_helper'

RSpec.describe 'Users index features' do
  before(:each) do
    User.destroy_all
    m = 3
    while m > 0
      @user = FactoryBot.create(:user, PostsCounter: 2)
      FactoryBot.create(:post, user_id: @user.id)
      FactoryBot.create(:post, user_id: @user.id)
      m -= 1
    end
    visit(root_path)
  end

  scenario 'Confirm that user is on the users index page' do
    expect(page).to have_content('Authors')
  end

  scenario 'Confirm that all users show on the page' do
    expect(page).to have_css('div.card.mb-3', count: User.count)
  end

  scenario 'Confirm that all user profile picture shows on the page' do
    users = User.all

    # check that all users image tag is present
    expect(page).to have_css('img.img-fluid.rounded-start', count: User.count)

    # check that each users image tag has the correct image
    users.each do |user|
      expect(page).to have_css("img[src*='#{user.Photo}']")
    end
  end

  scenario 'Confirm that the number of posts for each user is showing on the page' do
    users = User.all
    users.each do |user|
      expect(page).to have_content("Number of posts: #{user.PostsCounter}")
    end
  end

  scenario "Confirm that user is redirected to user's show page when user is clicked" do
    user = User.first
    click_on user.Name
    expect(page).to have_current_path(user_path(user))
  end
end
