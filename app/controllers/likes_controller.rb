class LikesController < ApplicationController
  def create
    new_like = current_user.likes.build
    new_like.post_id = params[:post_id]
    new_like.user_id = current_user.id

    check_liked = Like.find_by(user_id: current_user.id, post_id: new_like.post_id)
    if check_liked.nil?
      respond_to do |format|
        format.html do
          if new_like.save
            flash[:success] = 'You liked this post'
          else
            flash[:danger] = 'There was a problem adding your like'
          end
        end
      end
    else
      flash[:danger] = 'You already liked this post'
    end
    redirect_to user_post_path(current_user.id, params[:post_id])
  end
end
