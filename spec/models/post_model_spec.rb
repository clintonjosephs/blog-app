require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user_id: @user.id)
  end

  it 'is valid with valid attributes' do
    expect(@post).to be_valid
  end

  it 'is not valid without a Title' do
    @post.Title = nil
    expect(@post).to_not be_valid
  end

  it 'is valid if Title length is less than 250' do
    @post.Title = 'How I enrolled in Microverse'
    expect(@post.Title.length).to be <= 250
  end

  it 'is not valid if Title length is greater than 250' do
    @post.Title = 'How I enrolled in Microverse' * 10
    expect(@post).to_not be_valid
  end

  it 'is not valid without a CommentsCounter' do
    @post.CommentsCounter = nil
    expect(@post).to_not be_valid
  end

  it 'is valid if comments counter is integer' do
    @post.CommentsCounter = 1
    expect(@post.CommentsCounter).to be_a(Integer)
  end

  it 'is valid if likes counter is greater than or equal to zero' do
    expect(@post.LikesCounter).to be >= 0
  end

  it 'is not valid without a LikesCounter' do
    @post.LikesCounter = nil
    expect(@post).to_not be_valid
  end

  it 'is valid if likes counter is integer' do
    @post.LikesCounter = 1
    expect(@post.LikesCounter).to be_a(Integer)
  end

  it 'is valid if likes counter is greater than or equal to zero' do
    expect(@post.LikesCounter).to be >= 0
  end

  it 'is not valid if user does not exist' do
    @post.user_id = nil
    expect(@post).to_not be_valid
  end
end
