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

if payload?
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
  last_video = lastPlayedVid()
  if last_video
    position = playlist.positionByVid(last_video)
  else
    position = 0
  playlist.playVideo(position)

onPlayerStateChange = (event) ->
  if event.data == -1 # unstarted / new vid
    video_id = player.getVideoData().video_id
    playlist.setPosition(video_id)
    updateCookie(video_id)

updateCookie = (video_id) ->
  h = {}
  h[playlist_id] = video_id
  cookie = Cookies.getJSON('playlists')
  Cookies.set('playlists', $.extend(cookie, h))

lastPlayedVid = ->
  cookie = Cookies.getJSON('playlists')
  cookie[playlist_id] if cookie
  
$(document).on 'click', '.playlist-item', (e) =>
  position = $(e.currentTarget).data('position')
  playlist.playVideo(position)
