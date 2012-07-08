require 'open-uri'

class PlayAsia::HttpClient
  def request(url, options)
    open url, *options
  end
end