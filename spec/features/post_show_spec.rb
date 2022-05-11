require 'rails_helper'

RSpec.describe 'Post show feature' do
  before(:each) do
    @user = FactoryBot.create(:user)
    m = 5
    while m > 0
      FactoryBot.create(:post, user_id: @user.id)
      m -= 1
    end
    @post = @user.posts.first
    visit(user_post_path(@user.id, @post.id))
  end

  scenario 'Confirm that we see the post title' do
    expect(page).to have_content(@post.Title.to_s)
  end

  scenario 'Confirm we can see who wrote the post' do
    expect(page).to have_content(@user.Name.to_s)
  end

  scenario 'Confirm that we can see how many comments the post has' do
    expect(page).to have_content("Comments: #{@post.comments.count}")
  end

  scenario 'Confirm that we see how many likes the post has' do
    expect(page).to have_content("Likes: #{@post.likes.count}")
  end

  scenario 'Confirm to see that we have the post body' do
    expect(page).to have_content(@post.Text.to_s)
  end

  scenario 'Confirm that we can see the username of each commentor' do
    @post.comments.includes(:user).each do |comment|
      expect(page).to have_content("#{comment.user.Name} : ")
    end
  end

  scenario 'Confirm that we can see the comment body for each user' do
    @post.comments.includes(:user).each do |comment|
      expect(page).to have_content("#{comment.user.Name} : #{comment.Text}")
    end
  end
end
