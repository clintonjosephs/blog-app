require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.new(Name: 'Benneth Green', Photo: 'https://imagescores.com/file2.jpg',
                  Bio: 'An amazing writer from the medivial times', PostsCounter: 0)
  before { user.save }

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user.Name = nil
    expect(user).to_not be_valid
  end

  it 'is valid if Name length is less than 250' do
    user.Name = 'Benneth Green'
    expect(user.Name.length).to be <= 250
  end

  it 'is not valid if Name length is greater than 250' do
    user.Name = 'Benneth Green' * 10
    expect(user.Name.length).to be <= 250
  end

  it 'is not valid without PostCounter' do
    user.PostsCounter = nil
    expect(user).to_not be_valid
  end

  it 'is valid if PostCounter is a number' do
    user.PostsCounter = 1
    expect(user.PostsCounter).to be_a(Integer)
  end

  it 'is valid if PostCounter is greater than or equal to 0' do
    user.PostsCounter = 0
    expect(user.PostsCounter).to be >= 0
  end
end
