# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dmm-ruby/version'

Gem::Specification.new do |gem|
  gem.name          = "dmm-ruby"
  gem.version       = DMM::VERSION
  gem.authors       = ["meganemura"]
  gem.email         = ["mura2megane@gmail.com"]
  gem.description   = %q{Client for the DMM Web Service API 2.0.}
  gem.summary       = %q{Client for the DMM Web Service API 2.0.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('faraday', '~> 0.8')
  gem.add_dependency('faraday_middleware')
  gem.add_dependency('multi_xml')
  gem.add_development_dependency('rspec')
  gem.add_development_dependency('webmock')
end
