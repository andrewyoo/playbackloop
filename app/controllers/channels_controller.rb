class ChannelsController < ApplicationController
  def show
    @channel = youtube_channel(params[:id])
    return redirect_to root_path, alert: 'Could not find the Channel' if @channel.nil?
    uploads_channel_id = @channel.content_details.related_playlists.uploads
    all_uploads = youtube_playlist(uploads_channel_id)
    @snippet = @channel.snippet
    @playlists = all_uploads + channel_playlists(params[:id])
  end
end
