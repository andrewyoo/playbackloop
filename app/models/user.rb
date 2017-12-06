class User < ApplicationRecord
  has_many :views
  
  def token_cache_key
    "user_#{id}_google_token"
  end
end
