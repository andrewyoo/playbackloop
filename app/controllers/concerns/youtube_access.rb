module YoutubeAccess
  extend ActiveSupport::Concern

  included do
    before_action :setup_youtube_service
  end

  def setup_youtube_service
    @ys = Google::Apis::YoutubeV3::YouTubeService.new
    @ys.key = Rails.application.credentials[Rails.env.to_sym][:google][:api_key]
    if current_user
      @ys.authorization = Rails.cache.fetch(current_user.token_cache_key, expires_in: 59.minutes) do
        GoogleTokenFetcher.new(current_user).fetch
      end
    end
  end

  def recent_playlists
    user_views = View.playlist.with_user(current_user).group(:list_id).order(Arel.sql('max(updated_at) desc')).limit(10).pluck(:list_id)
    playlist_ids = (recent_playlists_cache - user_views - cookie_playlist_ids).slice(0, 10)
    youtube_playlist(playlist_ids).slice(0, 6)
  end

  def current_playlists(limit = 6)
    if current_user
      playlist_ids = current_user.views.playlist.recently_played.limit(limit).pluck(:list_id)
    else
      playlist_ids = cookie_playlist_ids
    end
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
    @ys.list_channels('snippet,content_details', id: channel_id).items.first
  end

  def cookie_playlist_ids
    cookie_views = JSON.parse(cookies[:playlists]) rescue {}
    cookie_views.keys
  end
end
