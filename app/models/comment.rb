class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def update_comment_counter
    post.increment!(:CommentsCounter)
  end
end
