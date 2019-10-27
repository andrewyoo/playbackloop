class PagesController < ApplicationController
  def index
    @current_playlists = current_playlists
    @recent_playlists = recent_playlists
  end
  
  def joke
    @joke = JokeFetcher.new.fetch
    if @joke
      render layout: false
    else
      head :ok
    end
  end
end
