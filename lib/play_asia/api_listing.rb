class PlayAsia::Api
  def listing(opts = {})
    opts = process_friendly_keys opts.merge({ query: :listing })
    response = query opts
    
    raise "Query error: '#{response.error_message}'" if response.error?
    
    response.content.search('item').map do |xml|
      item = {}
      xml.search('*').each do |node|
        item[node.name.to_sym] = node.text
      end
      item
    end
  end
  
  private
  MASK = {
    price: 'p',
    barcodes: 'j',
    manufacturer_codes: 'm',
    sale_info: 's',
    release_date: 'r',
    name: 'n',
    image: 'i',
    url: 'l',
    affiliate_url: 'a',
    genre: 'g',
    version: 'v',
    encoding: 'e',
    compatibility: 'c'
  }
  
  def process_friendly_keys opts
    if opts[:mask] && opts[:mask].is_a?(Array)
      opts[:mask] = opts[:mask].map { |k| MASK[k] || k }.join
    end
    opts
  end
end