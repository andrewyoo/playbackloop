class SessionsController < ApplicationController
rescue_from OmniAuth::Strategies::OAuth2::CallbackError, with: :access_denied

  def new
    if logged_in?
      redirect_to_target_or_default root_path
    else
      redirect_to '/auth/google_oauth2'
    end
  end
  
  def destroy
    self.current_user = nil
    cookies.delete :playlists
    redirect_to root_path
  end

  def create
    authenticator = RegistrationAuth.new(auth_hash)
    user = authenticator.find_or_create_user
    if user
      self.current_user = user
      redirect_to_target_or_default root_path, notice: "You have connected with Youtube"
    else
      redirect_to_target_or_default root_path, alert: "You could not be connected to Youtube"
    end
  end
  
  def failure
    redirect_to root_path, alert: 'Could not connect to Youtube' 
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
