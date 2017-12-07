require 'google/apis/youtube_v3'

module YoutubeAccess
  extend ActiveSupport::Concern

  included do
    before_action :setup_youtube_service
  end

  def setup_youtube_service
    @ys = Google::Apis::YoutubeV3::YouTubeService.new
    @ys.key = Rails.application.secrets.google[:api_key]
    if current_user
      @ys.authorization = Rails.cache.fetch(current_user.token_cache_key, expires_in: 59.minutes) do
        GoogleTokenFetcher.new(current_user).fetch
      end
    end
  end
  
  def recent_playlists
    playlist_ids = View.playlist.group(:list_id).order('max(updated_at)').limit(6).pluck(:list_id)
    youtube_playlist(playlist_ids)
  end
  
  def current_playlists
    playlist_ids = current_user.views.playlist.recently_played.limit(6).pluck(:list_id)
    youtube_playlist(playlist_ids)
  end
  
  def youtube_playlist(ids)
    YoutubePlaylistFetcher.new(@ys, ids: ids).fetch.items
  end
  
  def channel_playlists(channel_id)
    YoutubePlaylistFetcher.new(@ys, channel_id: channel_id).fetch.items
  end
  
  def user_playlists
    YoutubePlaylistFetcher.new(@ys, mine: true).fetch.items
  end
  
  def channel_subscriptions
    @ys.list_subscriptions('snippet', mine: true, max_results: 50).items
  end
  
  def youtube_channel(channel_id)
    @ys.list_channels('snippet, content_details', id: channel_id).items.first
  end
end
