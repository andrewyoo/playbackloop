require 'google/apis/youtube_v3'
    
class PlaylistsController < ApplicationController
  def show
    @items = preload_playlist(params[:id])
    @items.sort! { |x,y| x.content_details.video_published_at <=> y.content_details.video_published_at }
  end
  
  private
  
  def preload_playlist(playlist_id)
    parts = "contentDetails,snippet"
    fields = "kind,next_page_token,page_info,prev_page_token,items(snippet(title,description,thumbnails/medium,position),contentDetails)"
    items = []
    page_token = nil
    begin
      list = @ys.list_playlist_items(parts, playlist_id: playlist_id, max_results: 50, page_token: page_token, fields: fields)
      items += list.items
      page_token = list.next_page_token
    end while page_token.present?
    items.reject { |i| i.content_details.video_published_at.nil? }
  end
end
