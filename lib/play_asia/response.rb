class PlayAsia::Response
  attr_accessor :raw_text
  attr_reader :status

  def initialize(text)
    @raw_text = text
    @parsed = Nokogiri::XML.parse text
  
    parse_content
  end

  def content
    @parsed.at 'content'
  end

  def error?
    status[:error] || false
  end

  def error_message
    status[:errorstring]
  end

  def query
    status[:query]
  end

  private
  def parse_content
    @status = parse_status
  end

  def parse_status
    {
      query: @parsed.at('status/query').text.to_sym,
      error: @parsed.at('status/error').text != '0',
      errorstring: @parsed.at('status/errorstring').text,
    }
  end
end