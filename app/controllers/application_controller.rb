class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :setup_youtube_service

  protect_from_forgery with: :exception
  
  private
  
  def setup_youtube_service
    @ys = Google::Apis::YoutubeV3::YouTubeService.new
    @ys.key = Rails.application.secrets.google[:api_key]
    #@ys.authorization = session[:google_token] if session[:google_token]
  end
end
