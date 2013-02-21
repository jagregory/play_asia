class PlayAsia::ResponseError < RuntimeError
end

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

  def start
    status[:start] ? status[:start].to_i : 0
  end

  def total_items
    status[:total_items] ? status[:total_items].to_i : nil
  end

  def items_count
    status[:items] ? status[:items].to_i : nil
  end

  def has_more?
    raise "Unknown total number of items" if total_items.nil?
    start + items.size < total_items
  end

  def complete?
    !has_more?
  end

  private
  def parse_content
    @status = parse_status
    @content = @parsed.at 'content'
    @items = parse_items

    raise PlayAsia::ResponseError, "status/items not found.\n#{status}" unless items_count || error?
    raise PlayAsia::ResponseError, "Unexpected number of items #{@items.size} instead of #{items_count}" if !error? && @items.size < items_count
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