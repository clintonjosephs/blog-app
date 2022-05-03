class PostsController < ApplicationController
  def index
  end

  def show 
    @post = Post.find(params[:id])
    @comments = @post.comments
    @likes = @post.likes
  end
end
