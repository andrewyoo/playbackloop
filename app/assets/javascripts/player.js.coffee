# theater mode
$(document).on 'click', '#view-mode-toggle', (e) =>
  $('#playlist-player').toggleClass('large-mode')

# dark mode
$(document).on 'click', '#dark-mode-toggle', (e) =>
  $('body').toggleClass('dark-mode')

# sleep timer
window.sleepTimer = new Timer(
  ontick: (ms) =>
    seconds = Math.round(ms / 1000)
    pad = (val) => if val > 9 then val else "0" + val
    clock = pad(Math.floor(seconds / 60)) + ':' + pad(seconds % 60)
    $("#sleep-timer-button").html(clock)
  onstart: () =>
    $("#sleep-timer-dropdown .stop-timer").show()
  onstop: () =>
    $("#sleep-timer-button").html('<i class="fa fa-hourglass-half"></i>')
    $("#sleep-timer-dropdown .stop-timer").hide()
  onend: () =>
    player.pauseVideo()
    $("#sleep-timer-button").html('<i class="fa fa-hourglass-half"></i>')
    $("#sleep-timer-dropdown .stop-timer").hide()
)

$(document).on 'click', '#sleep-timer-dropdown .dropdown-item', (e) =>
  e.preventDefault()
  sleepTimer.stop()
  seconds = $(e.target).data('value')
  sleepTimer.start(seconds)
    
