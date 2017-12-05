require 'google/apis/youtube_v3'

class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :setup_youtube_service

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
end
