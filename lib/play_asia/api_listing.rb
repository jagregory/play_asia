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

  TYPES = {
    accessory: 2,
    cd: 3,
    groceries: 7,
    apparel: 8,
    electronics: 9,
    movie: 4,
    book: 6,
    game: 1,
    toy: 5
  }
  
  def process_friendly_keys opts
    if opts[:mask] && opts[:mask].is_a?(Array)
      opts[:mask] = opts[:mask].map { |k| MASK[k] || k }.join
    end

    if opts[:type] && opts[:type].is_a?(Array)
      opts[:type] = opts[:type].map { |k| TYPES[k] || k }.join ','
    end
    
    opts
  end
end