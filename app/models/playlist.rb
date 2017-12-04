class Playlist
  attr_accessor :service, :playlist_id, :items, :parts, :fields, :max_results, :page_token, :title, :total
  
  def initialize(service, playlist_id)  
    @service = service
    @playlist_id = playlist_id
    @items = []
    @page_token = nil
    @parts = 'contentDetails,snippet'
    @fields = 'kind,next_page_token,page_info,prev_page_token,items(snippet(title,description,thumbnails/medium,position),contentDetails)'
    @max_results = 50
  end
  
  def load_playlist
    begin
      list = service.list_playlist_items(parts, 
        playlist_id: playlist_id, 
        max_results: max_results, 
        page_token: page_token, 
        fields: fields)
      @items += list.items
      @page_token = list.next_page_token
    end while page_token.present?
    @items.reject { |i| i.content_details.video_published_at.nil? }
  end
  
  private
  
  def set_playlist_attributes
    @title ||= 'hi'
  end
end
