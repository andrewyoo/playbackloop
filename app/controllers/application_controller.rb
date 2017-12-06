require 'google/apis/youtube_v3'

class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :setup_youtube_service
  before_action :sync_views, if: :current_user
  protect_from_forgery with: :exception
  
  private
  
  def setup_youtube_service
    @ys = Google::Apis::YoutubeV3::YouTubeService.new
    @ys.key = Rails.application.secrets.google[:api_key]
    if current_user
      @ys.authorization = Rails.cache.fetch(current_user.token_cache_key, expires_in: 59.minutes) do
        GoogleTokenFetcher.new(current_user).fetch
      end
    end
  end
  
  def sync_to_cookies
    views = current_user.views.playlist.recently_played.limit(50)
    list = {}
    views.each { |v| list[v.list_id] = [v.video_id, v.sort_order] }
    cookies[:playlists] = list.to_json
  end
  
  def sync_to_db
    views = JSON.parse(cookies[:playlists]) rescue {}
    views.each do |k,v|
      view = current_user.views.playlist.where(list_id: k).first_or_create
      video_id, sort_order = v
      view.update(video_id: video_id, sort_order: sort_order)
    end
  end
  
  def sync_views
    # order matters here. Get the latest from request cookie first
    sync_to_db
    sync_to_cookies
  end
end
