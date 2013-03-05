require 'minitest/autorun'
require 'play_asia'
require_relative 'stubs/stubbed_http_client'

class ApiTest < MiniTest::Unit::TestCase
  STUBBED_RESPONSE = '<message><status><query>test</query><error>0</error><errorstring /><items>1</items></status><content><item>1</item></content></message>'

  def setup
    @api = PlayAsia::Api.new
    @http_client = StubbedHttpClient.new STUBBED_RESPONSE
    def @api.http_client
      @http_client
    end
  end

  def test_query_defaults_to_using_play_asia_domain
    query = @api.query(key: 'api_key', user: 1, query: 'test')

    assert query.url.start_with? 'http://www.play-asia.com/__api__.php'
  end

  def test_query_uses_arguments_as_query_string
    query = @api.query(key: 'api_key', user: 1, query: 'test', a: 1, b: 2, c: 3)
    query_string = parse_hash_from_query_string query.url.split('?').last

    assert_equal query_string['key'], 'api_key'
    assert_equal query_string['user'], '1'
    assert_equal query_string['query'], 'test'
    assert_equal query_string['a'], '1'
    assert_equal query_string['b'], '2'
    assert_equal query_string['c'], '3'
  end

  def test_query_raises_if_no_key_given
    ex = assert_raises ArgumentError do
      @api.query user: 1, query: 'test'
    end
    assert_equal ex.message, 'Missing API key (expected :key)'
  end

  def test_query_raises_if_no_user_given
    ex = assert_raises ArgumentError do
      @api.query key: 'api_key', query: 'test'
    end
    assert_equal ex.message, 'Missing User ID (expected :user)'
  end

  def test_query_raises_if_no_query_name_given
    ex = assert_raises ArgumentError do
      @api.query key: 'api_key', user: 1
    end
    assert_equal ex.message, 'Missing Query type (expected :query)'
  end

  private
  def parse_hash_from_query_string query_string
    hash = {}
    query_string.split('&').each do |pair|
      key,value = pair.split '='
      hash[key] = value
    end
    hash
  end
end