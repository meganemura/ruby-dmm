source 'https://rubygems.org'

group :development, :test do
  gem 'rake'
  gem 'rspec', '>= 2.11'
  gem 'webmock'
  gem 'pry'
  gem 'guard-rspec'
  gem 'ox'
  gem 'rubocop', '~> 0.14.1' if RUBY_VERSION >= '1.9.0'
end

group :test do
  gem 'coveralls', :require => false
  gem 'simplecov', :require => false
end

gemspec
