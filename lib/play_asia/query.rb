class PlayAsia::Query
  attr_reader :url

  def initialize(http_client)
    @endpoint = 'http://www.play-asia.com/__api__.php'
    @http_client = http_client
  end

  def build(headers, opts)
    @url = build_url(@endpoint, opts)
  end

  def exec
    PlayAsia::Response.new @http_client.request(@url, headers).read
  end

  private
  def build_url(endpoint, opts)
    opts = prepare_opts opts
    ensure_required_parameters opts
    params = opts.map { |k,v| "#{k}=#{v}" }.join '&'
    "#{endpoint}?#{params}"
  end

  def prepare_opts(opts)
    opts
  end

  def ensure_required_parameters opts
    raise ArgumentError, 'Missing API key (expected :key)' unless opts[:key]
    raise ArgumentError, 'Missing User ID (expected :user)' unless opts[:user]
    raise ArgumentError, 'Missing Query type (expected :query)' unless opts[:query]
  end
end