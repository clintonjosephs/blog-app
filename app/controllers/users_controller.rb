class UsersController < ApplicationController
  def index
    @all_users = User.all.includes(:posts)
  end

  def show
    @user = User.find(params[:id])
    @user_update = User.new
  end

  def update
   user_to_update = User.find(params[:id])
   user_to_update.role = params[:role] == "0" ? 'nil' : "admin"
    if user_to_update.save
      if user_to_update.role == 'nil'
        flash[:info] = "#{user_to_update.Name}'s no longer an admin"
      else
        flash[:success] = "#{user_to_update.Name} is now an admin"
      end
    else
      flash[:danger] = 'There was a problem updating admin status'
    end
    redirect_to root_path
  end

  def destroy
  end
end
