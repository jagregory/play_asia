# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require File.expand_path('../lib/play_asia/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["James Gregory"]
  gem.email         = ["james@getonthegame.com.au"]
  gem.description   = "Play Asia API thin wrapper"
  gem.summary       = "Play Asia API"
  gem.homepage      = "http://github.com/jagregory/play_asia_gem"

  gem.files         = Dir.glob '**/*'
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "play_asia"
  gem.require_paths = ["lib"]
  gem.version       = PlayAsia::VERSION
  
  gem.add_runtime_dependency 'nokogiri'
  gem.add_development_dependency 'minitest-reporters'
end
