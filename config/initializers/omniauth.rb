creds = Rails.application.credentials[Rails.env.to_sym]
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, creds[:google][:client_id], creds[:google][:secret], scope: 'profile,email,youtube.readonly'
end
