# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby-dmm/version'

Gem::Specification.new do |gem|
  gem.name          = 'ruby-dmm'
  gem.version       = DMM::VERSION
  gem.authors       = ['meganemura']
  gem.email         = ['mura2megane@gmail.com']
  gem.description   = 'Client for the DMM Web Service API 2.0.'
  gem.summary       = 'Client for the DMM Web Service API 2.0.'
  gem.homepage      = ''

  gem.files         = `git ls-files -z`.split("\x0")
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
  gem.licenses      = ['MIT']
  gem.homepage      = 'https://github.com/meganemura/ruby-dmm'

  gem.add_dependency 'faraday', '~> 0.8'
  gem.add_dependency 'faraday_middleware'
  gem.add_dependency 'rash'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '~> 3.4.0'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rubocop', '~> 0.40.0'
  gem.add_development_dependency 'coveralls'
  gem.add_development_dependency 'simplecov'
end
