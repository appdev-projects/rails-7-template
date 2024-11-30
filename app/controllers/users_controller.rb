class UsersController < ApplicationController
  def home
    @users = User.all
  end

  def pals
    @users = User.page(params[:page]).per(8)
    @breadcrumbs = [
      {content: "Home", href: "/"},
      {content: "Pals", href: "/pals"},
    ]
  end

  def show
    @user = User.find_by!(id: params.fetch(:id))
    @breadcrumbs = [
      {content: "Home", href: "/"},
      {content: "Pals", href: "/pals"},
      {content: @user.pal_name},
    ]
  end

  def underconstruction
  end
end
