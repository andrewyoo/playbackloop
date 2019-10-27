class JokeFetcher
  URL = 'https://icanhazdadjoke.com/'
  
  def fetch
    response.parsed_response['joke'] if response.ok?
  end
  
  def response
    @response ||= HTTParty.get(URL, headers: headers)
  end
  
  def headers
    {
      'User-Agent' => 'playbackloop.com',
      'Accept' => 'application/json'
    }
  end
end
