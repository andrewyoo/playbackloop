Playbackloop::Application.config.middleware.use ExceptionNotification::Rack,
  email: {
    email_prefix: "[#{APP_NAME}][#{Rails.env}] ",
    sender_address:  "PBL Exceptions <#{Rails.application.secrets.sender_email}>",
    exception_recipients: [Rails.application.secrets.errors_email],
  } if Rails.env.production? || Rails.env.staging?
