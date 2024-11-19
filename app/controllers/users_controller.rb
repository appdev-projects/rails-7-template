class UsersController < ApplicationController
  def show
    @user = User.find_by!(username: params.fetch(:username))
  end
end
