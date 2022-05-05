class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def new
    @current_user = current_user
    @post = Post.new
  end

  def create
    new_post = current_user.posts.build(post_params)
    new_post.CommentsCounter = 0

    respond_to do |format|
      format.html do
        if new_post.save
          flash[:success] = 'Post was successfully created.'
          redirect_to user_posts_path(current_user)
        else
          flash[:danger] = 'Post was not created.'
          redirect_to new_user_post_path(current_user.id)
        end
      end
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @likes = @post.likes
  end

  private

  def post_params
    params.require(:post).permit(:Title, :Text)
  end
end
