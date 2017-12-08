class ApplicationController < ActionController::Base
  include SessionsHelper
  include YoutubeAccess
  before_action :sync_views, if: :current_user
  protect_from_forgery with: :exception
  
  private
  
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
  
  def recent_playlists_cache
    Rails.cache.fetch('recent_playlists') do
      View.playlist.group(:list_id).order('max(updated_at) desc').limit(100).pluck(:list_id)
    end
  end
end
