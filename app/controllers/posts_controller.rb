class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    new_post = Post.new(post_params)
    new_post.user_id = current_user.id
    respond_to do |format|
      format.html do
        if new_post.save
          flash[:success] = 'Post was successfully created.'
          redirect_to user_posts_path(current_user)
        else
          flash.now[:danger] = 'Post was not created because <ul class="error-list">' 
            new_post.errors.full_messages.each do |msg|
              flash.now[:danger] += "<li>#{msg}</li>"
            end
          flash.now[:danger] += '</ul>'
          render :new
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
