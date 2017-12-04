require 'google/apis/youtube_v3'
    
class PlaylistsController < ApplicationController
  def show
    @playlist = Playlist.new(@ys, params[:id])
    @playlist.load_playlist
    @items = @playlist.items
    @items.sort! { |x,y| x.content_details.video_published_at <=> y.content_details.video_published_at }
    @playing = @items.first
  end
  
end
