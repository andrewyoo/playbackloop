module PlaylistsHelper
  def sort_order_options(active = nil)
    options = [
      ['Oldest First', :date_asc],
      ['Newest First', :date_desc],
      ['Playlist Order', :position_asc],
      ['Title', :title]
    ]
    options_for_select(options, active)
  end
  
  def sleep_timer_options
    {
      '15 Mins' => 15 * 60,
      '30 Mins' => 30 * 60,
      '45 Mins' => 45 * 60,
      '1 Hour' => 60 * 60,
      '1.5 Hour' => 90 * 60
    }
  end
end
