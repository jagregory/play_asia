require 'open-uri'
require 'nokogiri'

class PlayAsia::API
  attr_accessor :endpoint
  attr_accessor :headers

  def initialize(opts = {})
    @opts = opts
    @endpoint = 'http://www.play-asia.com/__api__.php'
  end

  def query(opts = {})
    opts = @opts.merge opts
    url = build_url @endpoint, opts
    headers = @headers || {}
  
    open url, *headers do |f|
      PlayAsia::Response.new f.read
    end
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