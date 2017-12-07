class AccountsController < ApplicationController
  before_action :require_login
  
  def show
    @current_playlists = current_playlists
    @user_playlists = user_playlists
    @channel_subscriptions = channel_subscriptions
  end
  
end
