class PagesController < ApplicationController
  def index
    if current_user
      @current_playlists = current_playlists
    end
    @recent_playlists = recent_playlists
  end
  
  private
  
  def recent_playlists
    playlist_ids = View.playlist.group(:list_id).order('max(updated_at)').limit(3).pluck(:list_id)
    response = @ys.list_playlists('snippet', id: playlist_ids.join(','))
    response.items
  end
  
  def current_playlists
    playlist_ids = current_user.views.playlist.recently_played.limit(3).pluck(:list_id)
    response = @ys.list_playlists('snippet', id: playlist_ids.join(','))
    response.items
  end
end
