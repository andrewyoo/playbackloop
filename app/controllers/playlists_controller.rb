class PlaylistsController < ApplicationController
  before_action :sync_to_cookies, only: :show
  before_action :set_sort_order, only: [:show, :items]
  after_action :cache_playlists_views
  
  def show
    @playlist = Playlist.new(@ys, params[:id])
    begin
      @playlist_info = @playlist.info
    rescue Google::Apis::ClientError => e
      return playlist_not_found 
    rescue Exception => e
      return playlist_not_found 
    end
  end
  
  def update
    return unless current_user
    view = current_user.views.playlist.where(list_id: params[:id]).first_or_create
    view.update(video_id: params[:video_id], sort_order: params[:sort_order], deleted_at: nil)
    head :ok
  end
  
  def items
    @playlist = Playlist.new(@ys, params[:id])
    begin
      @playlist.load_playlist
    rescue Google::Apis::ClientError => e
      return playlist_not_found
    rescue Exception => e
      return playlist_not_found
    end
    items = @playlist.sorted_items(@sort_order)
    render 'playlists/_playlist', locals: { items: items, playing: items.first }, layout: false
  end
  
  def destroy
    return unless current_user
    @view = current_user.views.playlist.find_by_list_id params[:id]
    if @view
      @view.deleted_at ||= Time.current
      @view.save
    end
  end
  
  private
  
  def playlist_not_found
    redirect_to root_path, alert: 'Could not find the Playlist'
  end
  
  def cache_playlists_views
    updated_playlists = recent_playlists_cache.unshift(params[:id]).uniq.slice(0,100)
    Rails.cache.write('recent_playlists', updated_playlists)
  end
  
  def set_sort_order
    @sort_order = params[:sort] || last_view_sort || cookie_sort || :date_asc
  end
  
  def last_view_sort
    current_user.views.playlist.where(list_id: params[:id]).first.try(:sort_order) if current_user
  end
  
  def cookie_sort
    cookie_playlist_views[params[:id]].try(:last)
  end
end
