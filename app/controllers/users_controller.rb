class UsersController < ApplicationController
  def home
    @users = User.all
  end

  def index
    @q = User.ransack(params[:q])
    @users = @q.result.page(params[:page]).per(8)

    @breadcrumbs = [
      { content: "Home", href: "/" },
      { content: "Pals", href: users_path },
    ]
  end

  def show
    @user = User.find_by!(id: params.fetch(:id))
    if current_user
      @message = Message.new(:sender_id => current_user.id, :recipient_id => @user.id)
    else
      @message = nil # Ensure no message is initialized if the user is not signed in
    end

    @breadcrumbs = [
      { content: "Home", href: "/" },
      { content: "Pals", href: users_path },
      { content: @user.pal_name },
    ]
  end

  def underconstruction
  end
end
