# ruby-dmm [![Build Status](https://travis-ci.org/meganemura/ruby-dmm.png?branch=master)](https://travis-ci.org/meganemura/ruby-dmm) [![Coverage Status](https://coveralls.io/repos/meganemura/ruby-dmm/badge.png?branch=master)](https://coveralls.io/r/meganemura/ruby-dmm?branch=master)

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
client = DMM.new(:api_id => "your_api_id", :affiliate_id => "your_affiliate_id", :result_only => true)
response = client.order("date").limit(5).item_list("妄想")
response.items.map {|item| item.title }
# => ["ココロ@ファンクション！",
#     "やらせてっ！てぃーちゃー学園旅行〜やらてぃーが学園を飛び出したァ！？〜（DVDPG）",
#     "彫刻ボディ 瀧川花音",
#     "目が奪われる瞬間 vol.02",
#     "彫刻ボディ 瀧川花音"]
```

### Choose your favorite XML Parser

You can use `ox`, `libxml`, `nokogiri` through `multi_xml`.

Add 'ox' and 'nokogiri' to your Gemfile, then it works below.

```ruby
> require 'ruby-dmm'
> MultiXml.parser # => MultiXml::Parsers::Ox
> MultiXml.parser = :nokogiri
> MultiXml.parser # => MultiXml::Parsers::Nokogiri
```

See [multi_xml documents](http://rdoc.info/gems/multi_xml).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## See also

[API Reference](https://affiliate.dmm.com/api/)

