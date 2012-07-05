class PlayAsia::API
  def listing(opts = {})
    response = query(opts.merge({ query: :listing }))
    
    raise "Query error: '#{response.error_message}'" if response.error?
    
    response.content.search('item').map do |xml|
      item = {}
      xml.search('*').each do |node|
        item[node.name] = node.text
      end
      item
    end
  end
end