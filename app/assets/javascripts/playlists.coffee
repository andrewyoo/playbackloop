class Playlist
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
    position = $(".playlist-item[data-vid='#{video_id}']").data('position')
    this.video(position)
  setPosition: (video_id) ->
    video = this.videoByVid(video_id)
    $('.playlist-item.active').removeClass('active')
    $(".playlist-item[data-vid='#{video_id}']").addClass('active')
    $('#now-playing .title').html(video.snippet.title)
    console.log video.snippet.description
    description = video.snippet.description.replace(/https?:\/\/[\S]*/ig, (x) -> "<a href='#{x}'>#{x}</a>")
    $('#now-playing .description pre').html(description)

videos = payload.map(JSON.parse)
window.playlist = new Playlist(items: videos)
  
window.onYouTubeIframeAPIReady = ->
  window.player = new (YT.Player)(
    'player',
    events:
      'onReady': onPlayerReady,
      'onStateChange': onPlayerStateChange)
  return

onPlayerReady = (event) ->
  player.loadPlaylist(playlist.videoIds())

onPlayerStateChange = (event) ->
  if event.data == -1 # unstarted / new vid
    video_id = player.getVideoData().video_id
    playlist.setPosition(video_id)

$(document).on 'click', '.playlist-item', (e) =>
  position = $(e.currentTarget).data('position')
  playlist.playVideo(position)
