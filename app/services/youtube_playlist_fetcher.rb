class YoutubePlaylistFetcher
  attr_accessor :service, :channel_id, :mine, :ids, :parts

  def initialize(service, parts: default_parts, channel_id: nil, mine: nil, ids: nil)
    @service = service
    @channel_id = channel_id
    @mine = mine
    @ids = ids
    @parts = parts
  end

  def fetch
    options = { channel_id: channel_id, mine: mine, id: ids_to_s, max_results: 50}.compact
    service.list_playlists(parts, options)
  end

  private

  def default_parts
    'snippet, content_details'
  end

  def ids_to_s
    ids.is_a?(Array) ? ids.join(',') : ids
  end
end
