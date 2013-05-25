# ruby-dmm [![Build Status](https://travis-ci.org/meganemura/ruby-dmm.png?branch=master)](https://travis-ci.org/meganemura/ruby-dmm)

Client for the DMM Web Service API 2.0.

## Installation

Add this line to your application's Gemfile:

    gem 'ruby-dmm'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby-dmm

## Usage

```ruby
client = DMM::Client.new("your_api_key", "your_affiliate_id")
response = client.item_list({:keyword => "Ruby"})
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## See also

[API Reference](https://affiliate.dmm.com/api/)

