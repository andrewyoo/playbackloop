class YoutubePlaylist < ApplicationRecord
  REFRESH_INTERVAL = 1.day

  def refreshed?
    Time.current < (updated_at + REFRESH_INTERVAL)
  end
end
