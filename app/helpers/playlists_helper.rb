module PlaylistsHelper
  def sort_order_options(active = nil)
    options = [
      ['Oldest First', :date_asc],
      ['Newest First', :date_desc],
      ['Playlist Order', :position_asc]
    ]
    options_for_select(options, active)
  end
end
