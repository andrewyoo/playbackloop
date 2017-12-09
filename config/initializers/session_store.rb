Rails.application.config.session_store :cookie_store, {
  key: '_playbackloop_session',
  expire_after: 365.days
}
