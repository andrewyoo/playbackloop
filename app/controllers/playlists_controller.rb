require 'google/apis/youtube_v3'
    
class PlaylistsController < ApplicationController
  def show
    @playlist = Playlist.new(@ys, params[:id])
    begin
      @playlist.load_playlist
    rescue Google::Apis::ClientError => e
      return playlist_not_found 
    end
    @items = @playlist.items
    @items.sort! { |x,y| x.content_details.video_published_at <=> y.content_details.video_published_at }
    @playing = @items.first
  end
  
  def create
    playlist_id = 
      if params[:playlist_id].match('http')
        url_params = Rack::Utils.parse_nested_query URI.parse(params[:playlist_id]).query
        url_params['list']
      else
        params[:playlist_id].to_s.strip
      end
    if playlist_id
      redirect_to playlist_path(id: playlist_id)
    else
      playlist_not_found
    end
  end
  
  private
  
  def playlist_not_found
    redirect_to root_path, alert: 'Could not find the Playlist'
  end
end
