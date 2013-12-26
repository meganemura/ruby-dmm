require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:rspec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rspec_opts = ['-cfd --backtrace']
end

task :default => :rspec

if RUBY_VERSION >= '1.9.0'
  require 'rubocop/rake_task'
  Rubocop::RakeTask.new do |task|
    task.patterns = %w(
      lib/**/*.rb
      spec/**/*.rb
      Rakefile
      Gemfile
      Guardfile
      ruby-dmm.gemspec
    )
  end
end
