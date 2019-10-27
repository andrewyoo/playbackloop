class AccountsController < ApplicationController
  before_action :require_login
  
  def show
    @current_playlists = current_playlists(12)
    @user_playlists = user_playlists
    @channel_subscriptions = channel_subscriptions
  end
  
end
