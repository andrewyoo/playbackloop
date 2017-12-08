class PagesController < ApplicationController
  def index
    @current_playlists = current_playlists
    @recent_playlists = recent_playlists
  end
end
