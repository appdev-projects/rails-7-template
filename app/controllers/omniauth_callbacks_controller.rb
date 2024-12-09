class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env["omniauth.auth"].except!(:extra))

    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: "GitHub") if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"].except!(:extra)
      redirect_to root_url, alert: "Something went wrong."
    end
  end
end
