require 'minitest/autorun'
require 'play_asia'
require 'minitest/mock'
require_relative 'stubs/stubbed_http_client'

class ApiTest < MiniTest::Unit::TestCase
  OK_RESPONSE = PlayAsia::Response.new '<message><status><query>test</query><error>0</error><errorstring /></status><content><test>1</test></content></message>'
  def test_should_map_mask_array_to_string
    api = PlayAsia::Api.new

    # overwrite the query method so we can grab the options passed to it
    class << api
      attr_reader :queried_options
      def query(opts = {})
        @queried_options = opts
        OK_RESPONSE
      end
    end

    api.listing mask: [:price, :barcodes, :manufacturer_codes, :sale_info, :release_date, :name, :image,
                       :url, :affiliate_url, :genre, :version, :encoding, :compatibility]

    assert_equal 'pjmsrnilagvec', api.queried_options[:mask]
  end
end