# PlayAsia

A thin wrapper around the [Play Asia](http://www.play-asia.com) API.

## Installation

Add this line to your application's Gemfile:

    gem 'play_asia'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install play_asia

## Usage

    api = PlayAsia::Api.new
      key: # your API key,
      user: # your API user
      
    api.listing(mask: [:price, :name], type: [:game]).exec
    # => PlayAsia::Response

    api.listing(mask: [:price, :name], type: [:game]).url
    # => http://www.play-asia.com/__api__.php?...

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request