class AddDefaultZeroToLikeCounterInPosts < ActiveRecord::Migration[7.0]
  def change
    change_column_default :posts, :LikesCounter, 0
    change_column_default :posts, :CommentsCounter, 0
  end
end
