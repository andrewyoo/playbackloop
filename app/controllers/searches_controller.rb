class SearchesController < ApplicationController
  before_action :require_query
  
  def create
    if playlist_url?
      url_params = Rack::Utils.parse_nested_query URI.parse(params[:query]).query
      playlist_id = url_params['list']
      redirect_to playlist_path(id: playlist_id)
    elsif channel_url?
      parts = params[:query].split('/')
      channel_str_index = parts.index('channel')
      channel_id = parts[channel_str_index + 1]
      redirect_to channel_path(id: channel_id)
    else
      playlist_id = params[:query].strip
      redirect_to playlist_path(id: playlist_id)
    end
  end
  
  private
  
  def playlist_url?
    params[:query].match('http') && params[:query].match('list=')
  end
  
  def channel_url?
    params[:query].match('http') && params[:query].match('/channel/')
  end
  
  def require_query
    redirect_to root_path, alert: 'Enter a Youtube playlist or channel url' if params[:query].blank?
  end
end
