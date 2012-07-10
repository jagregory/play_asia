class PlayAsia::Response
  attr_reader :raw_text, :status, :items, :content

  def initialize(text)
    @raw_text = text
    @parsed = Nokogiri::XML.parse text
  
    parse_content
  end

  def error?
    status[:error] != '0'
  end

  def error_message
    status[:errorstring]
  end

  private
  def parse_content
    @status = parse_status
    @content = @parsed.at 'content'
    @items = parse_items
  end

  def parse_status
    dumb_xml_to_hash @parsed.at('status')
  end

  def parse_items
    content.search('item').map do |xml|
      dumb_xml_to_hash xml
    end
  end

  def dumb_xml_to_hash(xml)
    hash = {}
    xml.search('*').each do |node|
      hash[node.name.downcase.to_sym] = node.text
    end
    hash
  end
end