class PagesController < ApplicationController
  def index
    if current_user
      @current_playlists = current_playlists
    end
    @recent_playlists = recent_playlists
  end
end
