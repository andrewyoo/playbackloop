class SessionsController < ApplicationController
  def new
    redirect_to_target_or_default root_path if logged_in?
  end
  
  def destroy
    self.current_user = nil
    redirect_to root_path
  end

  def create
    session[:google_token] = auth_hash.credentials.token
    redirect_to_target_or_default root_path, notice: "You have connected with #{params[:provider]}"
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
