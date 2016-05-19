# encoding: utf-8

require 'faraday'
require 'faraday_middleware'
require 'ruby-dmm/response'
require 'ruby-dmm/version'

module DMM
  class Client

    BASE_URL = 'https://api.dmm.com/affiliate/v3/'.freeze
    DEFAULT_USER_AGENT = "ruby-dmm gem #{DMM::VERSION}".freeze

    def initialize(options = {})
      @api_id       = (ENV['DMM_API_ID']       || options[:api_id])
      @affiliate_id = (ENV['DMM_AFFILIATE_ID'] || options[:affiliate_id])
      @user_agent   = (ENV['DMM_USER_AGENT']   || options[:user_agent] || DEFAULT_USER_AGENT)
    end

    API_MAP = {
      product: 'ItemList',      # 商品情報
      floor:   'FloorList',     # フロア
      actress: 'ActressSearch', # 女優検索
      genre:   'GenreSearch',   # ジャンル検索
      maker:   'MakerSearch',   # メーカー検索
      series:  'SeriesSearch',  # シリーズ検索
      author:  'AuthorSearch',  # 作者検索
    }.freeze

    API_MAP.each do |method, path|
      define_method method do |params = {}|
        get(path, credentials.merge(params))
      end
    end

    private

    def credentials
      {
        api_id:       @api_id,
        affiliate_id: @affiliate_id,
      }
    end

    def get(path, options = {})
      Response.new(connection.get(path, options))
    end

    def connection
      @connection ||= Faraday.new(faraday_options) do |faraday|
        faraday.adapter  Faraday.default_adapter
        faraday.request  :url_encoded
        faraday.response :json
      end
    end

    def faraday_options
      {
        url: BASE_URL,
        headers: {
          user_agent: @user_agent,
        },
      }
    end
  end
end
