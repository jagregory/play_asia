class PlayAsia::Api
  attr_accessor :headers

  def initialize(opts = {})
    @opts = opts
    @http_client = PlayAsia::HttpClient.new
  end

  def query(opts = {})
    query = PlayAsia::Query.new http_client
    query.build(@headers || {}, @opts.merge(opts))
    query
  end

  def listing(opts = {})
    query = PlayAsia::ListingQuery.new http_client
    query.build(@headers || {}, @opts.merge(opts))
    query
  end

  private
  def http_client
    @http_client
  end
end