class StubbedHttpClient
  attr_reader :last_url, :last_options

  def initialize response
    @response = response
  end

  def request url, options
    @last_url = url
    @last_options = options
    
    StubFileResponse.new @response
  end

  private
  class StubFileResponse
    def initialize content
      @content = content
    end

    def read
      @content
    end
  end
end