class Post < ApplicationRecord
  belongs_to :user

  has_many :comments
  has_many :likes

  validates :Title, presence: true, length: { maximum: 250 }
  validates :CommentsCounter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :LikesCounter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_comments
    comments.limit(5).order(created_at: :desc)
  end

  def update_post_counter
    user.increment!(:PostsCounter)
  end
end
