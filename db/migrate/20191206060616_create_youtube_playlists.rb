class CreateYoutubePlaylists < ActiveRecord::Migration[5.2]
  def change
    create_table :youtube_playlists do |t|
      t.string :youtube_id, index: true, null: false
      t.string :title
      t.integer :playlist_count
      t.text :description
      t.string :thumbnail_url
      t.string :channel_title
      t.string :youtube_channel_id
      t.timestamps
    end
  end
end
