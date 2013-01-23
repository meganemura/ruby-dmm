# dmm-ruby [![Build Status](https://travis-ci.org/meganemura/dmm-ruby.png?branch=master)](https://travis-ci.org/meganemura/dmm-ruby)

Client for the DMM Web Service API 2.0.

## Installation

Add this line to your application's Gemfile:

    gem 'dmm-ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dmm-ruby

## Usage

    client = DMM::Client.new("your_api_key", "your_affiliate_id")
    response = client.get({:keyword => "Ruby"})

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## See also

[API Reference](https://affiliate.dmm.com/api/)
