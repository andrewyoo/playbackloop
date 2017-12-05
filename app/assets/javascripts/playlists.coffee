class window.Playlist
  constructor: ({ @items }) ->
  videoIds: -> 
    @items.map (video) -> video.contentDetails.videoId
  videoIdsAfterPosition: (position) ->
    this.videoIds().slice(position)
  playVideo: (position) ->
    player.loadPlaylist(this.videoIdsAfterPosition(position))
    $('html, body').animate({ scrollTop: 0 }, 'slow')
  video: (position) ->
    @items[position]
  videoByVid: (video_id) ->
    position = this.positionByVid(video_id) 
    this.video(position)
  setPosition: (video_id) ->
    video = this.videoByVid(video_id)
    $('.playlist-item.active').removeClass('active')
    $(".playlist-item[data-vid='#{video_id}']").addClass('active')
    $('#now-playing .title').html(video.snippet.title)
    description = video.snippet.description.replace(/https?:\/\/[\S]*/ig, (x) -> "<a href='#{x}' target='_blank'>#{x}</a>")
    $('#now-playing .description pre').html(description)
  positionByVid: (video_id) ->
    $(".playlist-item[data-vid='#{video_id}']").data('position')
  
$(document).on 'click', '.playlist-item', (e) =>
  e.preventDefault()
  position = $(e.currentTarget).data('position')
  playlist.playVideo(position)
