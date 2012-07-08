require 'nokogiri'

class PlayAsia::Api
  attr_accessor :endpoint
  attr_accessor :headers
  attr_accessor :http_client

  def initialize(opts = {})
    @opts = opts
    @endpoint = 'http://www.play-asia.com/__api__.php'
    @http_client = PlayAsia::HttpClient.new
  end

  def query(opts = {})
    opts = @opts.merge opts
    url = build_url @endpoint, opts
    headers = @headers || {}

    PlayAsia::Response.new @http_client.request(url, headers).read
  end
  
  private
  def build_url(endpoint, opts)
    ensure_required_parameters opts
  
    params = opts.map { |k,v| "#{k}=#{v}" }.join '&'
    "#{endpoint}?#{params}"
  end

  def ensure_required_parameters opts
    raise ArgumentError, 'Missing API key (expected :key)' unless opts[:key]
    raise ArgumentError, 'Missing User ID (expected :user)' unless opts[:user]
    raise ArgumentError, 'Missing Query type (expected :query)' unless opts[:query]
  end
end