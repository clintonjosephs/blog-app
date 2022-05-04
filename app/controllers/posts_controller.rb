class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def new
    @current_user = current_user
  end

  def create
    new_post = current_user.posts.build(post_params)

    respond_to do |format|
      if new_post.save
        format.html { redirect_to user_posts_path(current_user), notice: 'Post was successfully created.' }
      else
        format.html { render :new, notice: 'Post was not created.' }
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
