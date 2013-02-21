# -*- encoding: utf-8 -*-
require File.expand_path('../lib/play_asia/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['James Gregory', 'On the Game']
  gem.email         = ['james@onthegame.com.au']
  gem.description   = 'A thin wrapper around the Play Asia API'
  gem.summary       = 'Play Asia API'
  gem.homepage      = 'http://www.onthegame.com.au/about/opensource'
  
  gem.add_runtime_dependency 'nokogiri'
  gem.add_development_dependency 'minitest-reporters'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'play_asia'
  gem.require_paths = ["lib"]
  gem.version       = PlayAsia::VERSION
end