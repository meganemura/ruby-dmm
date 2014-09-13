# vim: ts=2 sts=2 et sw=2 ft=ruby

ENV['GUARD_TEST'] = 'true'

guard 'rspec', :all_after_pass => false, :all_on_start => false do
  watch(%r{spec/.+_spec\.rb$})
  watch(%r{lib/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{lib/(.+)/(.+)\.rb$}) { |m| "spec/#{m[1]}/#{m[2]}_spec.rb" }
  watch(%r{lib/ruby-dmm/(.+)/(.+)\.rb$}) { |m| "spec/#{m[1]}/#{m[2]}_spec.rb" }
end
