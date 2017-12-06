class RegistrationAuth
  attr_reader :auth_hash

  def initialize(auth_hash)
    @auth_hash = auth_hash
  end

  def find_or_create_user
    User.where(email: auth_hash.info.email).first_or_create do |u|
      u.name = auth_hash.info.name
      u.username = auth_hash.info.name
      u.avatar_url = auth_hash.info.image
      # for google store in cache with expiration at 1 hour
      # u.access_token = auth_hash.credentials.token
      u.refresh_token = auth_hash.credentials.refresh_token
    end.tap { |u| Rails.cache.write(u.token_cache_key, auth_hash.credentials.token, expires_in: 59.minutes) }
  end
end
