require 'minitest/autorun'
require 'play_asia'
require 'minitest/mock'
require_relative 'stubs/stubbed_http_client'

class ApiListingTest < MiniTest::Unit::TestCase
  KEY = 'abc'
  USER = 1
  OK_RESPONSE = PlayAsia::Response.new '<message><status><query>test</query><error>0</error><errorstring /><items>1</items></status><content><item>1</item></content></message>'

  def setup
    @api = PlayAsia::Api.new
    @http_client = StubbedHttpClient.new OK_RESPONSE
    def @api.http_client
      @http_client
    end
  end

  def test_should_map_mask_array_to_string
    query = @api.listing(key: KEY, user: USER, mask: [:price, :barcodes, :manufacturer_codes, :sale_info, :release_date, :name, :image,
       :url, :affiliate_url, :genre, :version, :encoding, :compatible])

    assert_equal 'http://www.play-asia.com/__api__.php?key=abc&user=1&mask=pjmsrnilagvec&query=listing', query.url
  end

  def test_should_use_string_for_mask_if_given
    query = @api.listing key: KEY, user: USER, mask: 'string'

    assert_equal 'http://www.play-asia.com/__api__.php?key=abc&user=1&mask=string&query=listing', query.url
  end

  def test_should_map_type_array_to_csv_of_integers
    query = @api.listing key: KEY, user: USER, type: [:accessory, :cd, :groceries, :apparel, :electronics, :movie, :book, :game, :toy]

    assert_equal 'http://www.play-asia.com/__api__.php?key=abc&user=1&type=2,3,7,8,9,4,6,1,5&query=listing', query.url
  end

  def test_should_use_string_for_type_if_given
    query = @api.listing key: KEY, user: USER, type: 'string'

    assert_equal 'http://www.play-asia.com/__api__.php?key=abc&user=1&type=string&query=listing', query.url
  end

  def test_should_map_genre_array_to_csv_of_integers
    query = @api.listing key: KEY, user: USER, genre: [:strategy_video_game, :racing_video_game, :simulation_video_game, :tv_series_dvd_vcd]

    assert_equal 'http://www.play-asia.com/__api__.php?key=abc&user=1&genre=10,11,12,122&query=listing', query.url
  end

  def test_should_use_string_for_genre_if_given
    query = @api.listing key: KEY, user: USER, genre: 'string'

    assert_equal 'http://www.play-asia.com/__api__.php?key=abc&user=1&genre=string&query=listing', query.url
  end

  def test_should_map_compatible_array_to_csv_of_integers
    query = @api.listing key: KEY, user: USER, compatible: [:dreamcast, :ipad]

    assert_equal 'http://www.play-asia.com/__api__.php?key=abc&user=1&compatible=9,111&query=listing', query.url
  end

  def test_should_use_string_for_compatible_if_given
    query = @api.listing key: KEY, user: USER, compatibility: 'string'

    assert_equal 'http://www.play-asia.com/__api__.php?key=abc&user=1&compatibility=string&query=listing', query.url
  end

  def test_should_map_encoding_array_to_csv_of_integers
    query = @api.listing key: KEY, user: USER, encoding: [:pal, :aac]

    assert_equal 'http://www.play-asia.com/__api__.php?key=abc&user=1&encoding=4,31&query=listing', query.url
  end

  def test_should_use_string_for_encoding_if_given
    query = @api.listing key: KEY, user: USER, encoding: 'string'

    assert_equal 'http://www.play-asia.com/__api__.php?key=abc&user=1&encoding=string&query=listing', query.url
  end

  def test_should_map_version_array_to_csv_of_integers
    query = @api.listing key: KEY, user: USER, version: [:asia, :hong_kong]

    assert_equal 'http://www.play-asia.com/__api__.php?key=abc&user=1&version=6,19&query=listing', query.url
  end

  def test_should_use_version_for_encoding_if_given
    query = @api.listing key: KEY, user: USER, version: 'string'

    assert_equal 'http://www.play-asia.com/__api__.php?key=abc&user=1&version=string&query=listing', query.url
  end

  def test_should_map_skip_preowned_boolean_true_to_1
    query = @api.listing key: KEY, user: USER, skip_preowned: true

    assert_equal 'http://www.play-asia.com/__api__.php?key=abc&user=1&skip_preowned=1&query=listing', query.url
  end

  def test_should_map_skip_preowned_boolean_false_to_0
    query = @api.listing key: KEY, user: USER, skip_preowned: false

    assert_equal 'http://www.play-asia.com/__api__.php?key=abc&user=1&skip_preowned=0&query=listing', query.url
  end

  def test_should_allow_string_for_skip_preowned
    query = @api.listing key: KEY, user: USER, skip_preowned: 'yes'

    assert_equal 'http://www.play-asia.com/__api__.php?key=abc&user=1&skip_preowned=yes&query=listing', query.url
  end
end