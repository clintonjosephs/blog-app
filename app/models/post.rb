class Post < ApplicationRecord
  belongs_to :user

  has_many :comments
  has_many :likes

  def recent_comments
    comments.limit(5).order(created_at: :desc)
  end

  def update_post_counter
    user.increment!(:PostsCounter)
  end

  def create_post
    Post.create(user_id: 2, Title: 'The downside of trade', Text: 'Blogging has long been a popular way for people to express their passions, experiences and ideas with readers worldwide. \n A blog can be its own website, or an add-on to an existing site. Whichever option you choose, it serves as a space to share your story or market your expertise in your own words, with your own visual language to match.')
  end
end
