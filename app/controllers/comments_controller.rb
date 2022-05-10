class CommentsController < ApplicationController
  def create
    new_comment = current_user.comments.build(comment_params)
    new_comment.post_id = params[:post_id]
    new_comment.user_id = current_user.id

    respond_to do |format|
      format.html do
        if new_comment.save
          new_comment.update_comment_counter
          flash[:success] = 'Comment has been posted successfully'
        else
          flash[:danger] = 'Comment was not created.'
        end
        redirect_to user_post_path(current_user.id, params[:post_id])
      end
    end
  end

  def destroy
    comment_to_delete = Comment.find(params[:id])
    post_with_comment = Post.find(params[:post_id])
    post_with_comment.CommentsCounter -= 1
    comment_to_delete.destroy
    post_with_comment.save
    flash[:info] = 'You comment has been deleted successfully!'
    redirect_to user_post_path(comment_to_delete.user_id, params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:Text)
  end
end
