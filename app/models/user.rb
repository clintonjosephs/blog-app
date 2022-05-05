class User < ApplicationRecord
  has_many :comments
  has_many :posts
  has_many :likes

  validates :Name, presence: true, length: { maximum: 250 }
  validates :PostsCounter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_posts
    posts.order(created_at: :desc).limit(3).includes(%i[comments likes])
  end
end
