class Playlist
  attr_accessor :service, :playlist_id, :items, :max_results, :page_token, :title, :total
  
  def initialize(service, playlist_id)  
    @service = service
    @playlist_id = playlist_id
    @items = []
    @page_token = nil
    @max_results = 50
  end
  
  def load_playlist
    begin
      list = service.list_playlist_items(list_playlist_items_parts, 
        playlist_id: playlist_id, 
        max_results: max_results, 
        page_token: page_token)
        #fields: list_playlist_items_fields)
      @items += list.items
      @page_token = list.next_page_token
    end while page_token.present?
    @items.reject! { |i| i.content_details.video_published_at.nil? }
  end
  
  def info
    @info ||= begin
      response = service.list_playlists('snippet', id: playlist_id)
      response.items.first.snippet
    end
  end
  
  def sorted_items(sort_order = :date_asc)
    case sort_order.to_sym
    when :date_asc
      items.sort { |x,y| x.content_details.video_published_at <=> y.content_details.video_published_at }
    when :date_desc
      items.sort { |x,y| y.content_details.video_published_at <=> x.content_details.video_published_at }
    when :position_desc
      items.reverse
    else # :position_asc
      items
    end
  end
  
  private
  
  def list_playlist_items_parts
    'contentDetails,snippet'
  end
  
  def list_playlist_items_fields
    'kind,next_page_token,page_info,prev_page_token,items(snippet(title,description,thumbnails/medium,position),contentDetails)'
  end
end
