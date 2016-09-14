class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :require_login
  
  def facebook
    expiresTime = Time.at(request.env["omniauth.auth"].credentials.expires_at) unless request.env["omniauth.auth"].credentials.expires_at.nil?
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"].provider, request.env["omniauth.auth"].uid, request.env["omniauth.auth"].extra.raw_info.name, request.env["omniauth.auth"].info.email, request.env["omniauth.auth"].credentials.token, request.env["omniauth.auth"].info.username, expiresTime ,current_user)

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"].uid
      redirect_to new_user_registration_url
    end
  end
end