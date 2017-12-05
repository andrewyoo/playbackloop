class User < ApplicationRecord
  def token_cache_key
    "user_#{id}_google_token"
  end
end
