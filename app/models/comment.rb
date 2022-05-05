class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :Text, presence: true, length: { maximum: 500 }

  def update_comment_counter
    post.increment!(:CommentsCounter)
  end
end
