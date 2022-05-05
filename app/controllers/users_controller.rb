class UsersController < ApplicationController
  def index
    @all_users = User.all.includes(:posts)
  end

  def show
    @user = User.find(params[:id])
  end
end
