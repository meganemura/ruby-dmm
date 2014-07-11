require "ruby-dmm"
require "webmock/rspec"

require 'coveralls'
Coveralls.wear!

# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

def fixture_path
  File.expand_path(File.dirname(__FILE__) + "/fixtures/")
end

def fixture(file)
  File.new(fixture_path + '/' + file, "rb")
end

def all_fixtures
  Dir.glob(fixture_path + '/' + "*.xml").map { |x| File.basename(x) }.sort
end

def fixtures
  if ENV['GUARD_TEST']
    all_fixtures.shuffle.pop(2)
  else
    all_fixtures
  end
end

def random_fixture
  all_fixtures.shuffle.first
end

def xml_response(file)
  {
    :body => fixture(file),
    :headers => {
      :content_type => 'text/xml; charset=euc-jp'
    }
  }
end

def stub_get
  stub_request(:get, Regexp.compile(Regexp.escape(DMM::Configuration::DEFAULT_API_ENDPOINT)))
end
