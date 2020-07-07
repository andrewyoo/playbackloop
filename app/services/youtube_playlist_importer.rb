class YoutubePlaylistImporter
  attr_accessor :playlist_item

  def initialize(playlist_item)
    @playlist_item = playlist_item
  end

  def import!
    youtube_playlist.tap(&:save!)
  end

  def snippet
    playlist_item.snippet
  end

  def content_details
    playlist_item.content_details
  end

  def youtube_playlist
    @youtube_playlist ||= YoutubePlaylist.where(youtube_id: playlist_item.id).first_or_initialize.tap do |yp|
      yp.title = snippet.title
      yp.description = snippet.description
      yp.channel_title = snippet.channel_title
      yp.youtube_channel_id = snippet.channel_id
      yp.playlist_count = content_details.item_count if content_details.present?
      yp.thumbnail_url = (snippet.thumbnails.high || snippet.thumbnails.standard).try(:url)
      yp.updated_at = Time.current
    end
  end
end
