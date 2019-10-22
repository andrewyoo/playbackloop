class GoogleTokenFetcher
  attr_accessor :user
  
  def initialize(user)
    @user = user
  end
  
  def fetch
    response = request_token
    data = JSON.parse response.body
    data['access_token']
  end
  
  def request_token
    url = URI('https://www.googleapis.com/oauth2/v4/token')
    Net::HTTP.post_form(url, params)  
  end
  
  private
  
  def params
    { 
      refresh_token: user.refresh_token,
      client_id: Rails.application.credentials[Rails.env.to_sym][:google][:client_id],
      client_secret: Rails.application.credentials[Rails.env.to_sym][:google][:secret],
      grant_type: 'refresh_token'
    }
  end
end
