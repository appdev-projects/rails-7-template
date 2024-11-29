class UsersController < ApplicationController
  def home
    @users = User.all
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by!(id: params.fetch(:id))
  end
end
