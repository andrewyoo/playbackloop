class PlaylistsController < ApplicationController
  def show
    @playlist = Playlist.new(@ys, params[:id])
    begin
      @playlist_info = @playlist.info
    rescue Google::Apis::ClientError => e
      return playlist_not_found 
    rescue Exception => e
      return playlist_not_found 
    end
  end
  
  def items
    @playlist = Playlist.new(@ys, params[:id])
    @playlist.load_playlist
    items = @playlist.items
    items.sort! { |x,y| x.content_details.video_published_at <=> y.content_details.video_published_at }
    playing = items.first
    render 'playlists/_playlist', locals: { items: items, playing: playing }, layout: false
  end
  
  private
  
  def playlist_not_found
    redirect_to root_path, alert: 'Could not find the Playlist'
  end
end
