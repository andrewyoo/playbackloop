class ApplicationController < ActionController::Base
  include SessionsHelper
  include YoutubeAccess
  protect_from_forgery with: :exception
  
  private
  
  # over 36 caused some 502 error after upgrading to rails 5.2 in production even though cookie was well under 4k
  def sync_to_cookies
    return unless current_user
    views = current_user.views.playlist.recently_played.limit(30)
    list = {}
    views.each { |v| list[v.list_id] = [v.video_id, v.sort_order] }
    cookies[:playlists] = { value: list.to_json, expires: 365.days.from_now }
  end
  
  def sync_to_db
    return unless current_user
    cookie_playlist_views.each do |k,v|
      view = current_user.views.playlist.where(list_id: k).first_or_create
      video_id, sort_order = v
      view.update(video_id: video_id, sort_order: sort_order)
    end
  end
  
  def recent_playlists_cache
    Rails.cache.fetch('recent_playlists') do
      View.playlist.not_deleted.group(:list_id).order(Arel.sql('max(updated_at) desc')).limit(100).pluck(:list_id)
    end
  end
  
  def cookie_playlist_views
    JSON.parse(cookies[:playlists]) rescue {}
  end
end
