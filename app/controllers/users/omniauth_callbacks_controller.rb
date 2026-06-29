# app/controllers/users/omniauth_callbacks_controller.rb
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token

  def google_oauth2
    auth = request.env["omniauth.auth"]
    if auth.nil?
      redirect_to "#{ENV.fetch('FRONTEND_URL', 'http://localhost:5173')}/login?error=google_auth_failed"
      return
    end
    user = User.from_google(
      uid:   auth["uid"],
      email: auth["info"]["email"],
      name:  auth["info"]["name"]
    )
    if user.persisted?
      token = JwtService.encode(user)
      redirect_to "#{ENV.fetch('FRONTEND_URL', 'http://localhost:5173')}/auth/callback?token=#{token}", allow_other_host: true
    else
      redirect_to "#{ENV.fetch('FRONTEND_URL', 'http://localhost:5173')}/login?error=google_auth_failed", allow_other_host: true
    end
  end
  def failure
    redirect_to "#{ENV.fetch('FRONTEND_URL', 'http://localhost:5173')}/login?error=google_auth_failed", allow_other_host: true
  end
end
