class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def new
    @user = User.new
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @likes = @post.likes
  end
end
