# ruby-dmm
[![Gem Version](https://img.shields.io/gem/v/ruby-dmm.svg?style=flat)](http://badge.fury.io/rb/ruby-dmm)
[![Build Status](https://img.shields.io/travis/meganemura/ruby-dmm.svg?style=flat)](https://travis-ci.org/meganemura/ruby-dmm)
[![Coverage Status](https://img.shields.io/coveralls/meganemura/ruby-dmm.svg?style=flat)](https://coveralls.io/r/meganemura/ruby-dmm?branch=master)
[![Code Climate](https://img.shields.io/codeclimate/github/meganemura/ruby-dmm.svg?style=flat)](https://codeclimate.com/github/meganemura/ruby-dmm)
[![Dependency Status](https://img.shields.io/gemnasium/meganemura/ruby-dmm.svg?style=flat)](https://gemnasium.com/meganemura/ruby-dmm)

Client for the DMM Web Service API v3

## Installation

Add this line to your application's Gemfile:

    gem 'ruby-dmm'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby-dmm

## Usage

```ruby
client = DMM.new(:api_id => "YOUR-API-ID", :affiliate_id => "YOUR-AFFILIATE-ID")
response = cli.product(:site => 'DMM.com', :keyword => '超能力', :sort => 'rank')
response.result[:items].map {|x| x[:title] }
# => ["僕のヒーローアカデミア",
#     "みんな！エスパーだよ！-欲望だらけのラブ・ウォーズ-",
#     "血界戦線 Vol.6 （ブルーレイディスク）",
#     "エルフェンリート",
#     "学園アリス",
#     "ストレイヤーズ・クロニクル",
#     "Honey Bitter",
#     "MONSTERZ モンスターズ",
#     "AREA D 異能領域",
#     "十十虫は夢を見る",
#     "蝶戦士ピンクフューリーS",
#     "バビル2世 ザ・リターナー",
#     "とある科学の超電磁砲",
#     "裸心の十字架",
#     "菊池俊輔 作曲50周年 CD-BOX Composer SHUNSUKE KIKUCHI 50th Anniversary",
#     "アライブ 最終進化的少年",
#     "恋は光",
#     "ホムンクルス",
#     "目隠しの国",
#     "AKIRA"]
```

DMM::Client interface is very similar to (dmm-js-sdk](https://github.com/DMMcomLabo/dmm-js-sdk).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## See also

[API Reference](https://affiliate.dmm.com/api/)

