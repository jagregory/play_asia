require 'minitest/autorun'
require 'play_asia'
require 'minitest/mock'
require_relative 'stubs/stubbed_http_client'

class ApiListingTest < MiniTest::Unit::TestCase
  OK_RESPONSE = PlayAsia::Response.new '<message><status><query>test</query><error>0</error><errorstring /><items>1</items></status><content><item>1</item></content></message>'

  def test_should_map_mask_array_to_string
    api = api_with_stubbed_query
    api.listing mask: [:price, :barcodes, :manufacturer_codes, :sale_info, :release_date, :name, :image,
                       :url, :affiliate_url, :genre, :version, :encoding, :compatible]

    assert_equal 'pjmsrnilagvec', api.queried_options[:mask]
  end

  def test_should_use_string_for_mask_if_given
    api = api_with_stubbed_query
    api.listing mask: 'string'

    assert_equal 'string', api.queried_options[:mask]
  end

  def test_should_map_type_array_to_csv_of_integers
    api = api_with_stubbed_query
    api.listing type: [:accessory, :cd, :groceries, :apparel, :electronics, :movie, :book, :game, :toy]

    assert_equal '2,3,7,8,9,4,6,1,5', api.queried_options[:type]
  end

  def test_should_use_string_for_type_if_given
    api = api_with_stubbed_query
    api.listing type: 'string'

    assert_equal 'string', api.queried_options[:type]
  end

  def test_should_map_genre_array_to_csv_of_integers
    api = api_with_stubbed_query
    api.listing genre: [:strategy_video_game, :racing_video_game, :simulation_video_game, :tv_series_dvd_vcd]

    assert_equal '10,11,12,122', api.queried_options[:genre]
  end

  def test_should_use_string_for_genre_if_given
    api = api_with_stubbed_query
    api.listing genre: 'string'

    assert_equal 'string', api.queried_options[:genre]
  end

  def test_should_map_compatible_array_to_csv_of_integers
    api = api_with_stubbed_query
    api.listing compatible: [:dreamcast, :ipad]

    assert_equal '9,111', api.queried_options[:compatible]
  end

  def test_should_use_string_for_compatible_if_given
    api = api_with_stubbed_query
    api.listing compatibility: 'string'

    assert_equal 'string', api.queried_options[:compatibility]
  end

  def test_should_map_encoding_array_to_csv_of_integers
    api = api_with_stubbed_query
    api.listing encoding: [:pal, :aac]

    assert_equal '4,31', api.queried_options[:encoding]
  end

  def test_should_use_string_for_encoding_if_given
    api = api_with_stubbed_query
    api.listing encoding: 'string'

    assert_equal 'string', api.queried_options[:encoding]
  end

  def test_should_map_version_array_to_csv_of_integers
    api = api_with_stubbed_query
    api.listing version: [:asia, :hong_kong]

    assert_equal '6,19', api.queried_options[:version]
  end

  def test_should_use_version_for_encoding_if_given
    api = api_with_stubbed_query
    api.listing version: 'string'

    assert_equal 'string', api.queried_options[:version]
  end

  def test_should_map_skip_preowned_boolean_true_to_1
    api = api_with_stubbed_query
    api.listing skip_preowned: true

    assert_equal '1', api.queried_options[:skip_preowned]
  end

  def test_should_map_skip_preowned_boolean_false_to_0
    api = api_with_stubbed_query
    api.listing skip_preowned: false

    assert_equal '0', api.queried_options[:skip_preowned]
  end

  def test_should_allow_string_for_skip_preowned
    api = api_with_stubbed_query
    api.listing skip_preowned: 'yes'

    assert_equal 'yes', api.queried_options[:skip_preowned]
  end

  def test_should_only_use_supplied_parameters_and_query
    api = api_with_stubbed_query
    api.listing type: [:game], mask: [:name]

    refute_nil api.queried_options[:type]
    refute_nil api.queried_options[:mask]
    assert_equal [:type, :mask, :query], api.queried_options.keys
  end

  private
  def api_with_stubbed_query
    api = PlayAsia::Api.new

    # overwrite the query method so we can grab the options passed to it
    class << api
      attr_reader :queried_options

      def query(opts = {})
        @queried_options = opts
        OK_RESPONSE
      end
    end

    api
  end
end