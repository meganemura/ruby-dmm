# encoding: utf-8
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'coveralls/rake/task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:rspec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rspec_opts = ['-cfd --backtrace']
end

RuboCop::RakeTask.new(:style)

Coveralls::RakeTask.new

task :default => %w(rspec style)
task :ci => %w(rspec style coveralls:push)
