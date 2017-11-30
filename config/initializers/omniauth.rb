secrets = Rails.application.secrets
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, secrets.google[:client_id], secrets.google[:secret], scope: 'userinfo.profile,userinfo.email,youtube.readonly'
end

