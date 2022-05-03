class UsersController < ActionController::Base

  def index
    @all_users = User.all
  end

  def show; end
end
