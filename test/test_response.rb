require 'minitest/autorun'
require 'play_asia'

class ResponseTest < MiniTest::Unit::TestCase
  def test_should_have_error_when_error_in_status
    assert error_response.error?
  end

  def test_should_have_error_message_when_errorstring_in_status
    error_message = 'I am an error!'

    assert_equal error_message, error_response_with_errorstring(error_message).error_message
  end

  def test_have_more_should_be_true_if_number_of_items_is_less_than_total_items
    assert ok_response_with_paged_items.has_more?
    refute ok_response_with_paged_items.complete?
  end

  def test_have_more_should_be_false_if_number_of_items_is_greater_or_equal_to_total_items
    refute ok_response_with_all_items.has_more?
    assert ok_response_with_all_items.complete?
  end

  private
  def error_response
    PlayAsia::Response.new '<message><status><error>1</error></status><content /></message>'
  end

  def error_response_with_errorstring(error_string)
    PlayAsia::Response.new "<message><status><error>1</error><errorstring>#{error_string}</errorstring></status><content /></message>"
  end

  def ok_response_with_paged_items
    PlayAsia::Response.new <<RESPONSE
<message>
  <status>
    <error>0</error>
    <errorstring />
    <total_items>2</total_items>
  </status>
  <content>
    <item>
      <name>one</name>
    </item>
  </content>
</message>
RESPONSE
  end

  def ok_response_with_all_items
    PlayAsia::Response.new <<RESPONSE
<message>
  <status>
    <error>0</error>
    <errorstring />
    <total_items>2</total_items>
  </status>
  <content>
    <item>
      <name>one</name>
    </item>
    <item>
      <name>two</name>
    </item>
  </content>
</message>
RESPONSE
  end
end