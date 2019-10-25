# theater mode
$(document).on 'click', '#view-mode-toggle', (e) =>
  $('#playlist-player').toggleClass('large-mode')

# dark mode
$(document).on 'click', '#dark-mode-toggle', (e) =>
  $('body').toggleClass('dark-mode')
