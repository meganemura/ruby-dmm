# encoding: utf-8
require 'faraday'
require 'faraday/response/raise_dmm_error'
require 'faraday_middleware'
require 'faraday_middleware/response/dmm_rashify'
require 'multi_xml_tweaks'
require 'ruby-dmm/response'
require 'ruby-dmm/client/item_list'

module DMM
  DEFAULT_API_VERSION   = '2.00'.freeze
  SITE_DMM_CO_JP        = 'DMM.co.jp'.freeze
  SITE_DMM_COM          = 'DMM.com'.freeze
  DEFAULT_SITE          = SITE_DMM_CO_JP

  class Client
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)
    attr_accessor :params

    def initialize(params={})
      params = params.inject({}) {|hash, (key, value)| hash.merge({key.to_sym => value})}
      @params = {
        :api_id       => params[:api_id],             # your own api_id
        :affiliate_id => params[:affiliate_id],       # your own api_id
        :operation    => nil,                         # "ItemList" is only available now.
        :version      => DEFAULT_API_VERSION,
        :timestamp    => Time.now.strftime("%F %T"),
        :site         => DEFAULT_SITE,
        :result_only  => false,                       # Set true to get only response.result.
      }.merge(params)

      DMM.options.each {|key, value| send("#{key}=", value) }
    end

    def operation(value)
      self.tap {|o| o.params.update(:operation => value) }
    end

    def all
      @params[:operation] ? get('/', @params) : nil
    end

    include DMM::Client::ItemList

    private

    def get(path, options={})
      encode_params!
      response = connection.get('/', options)
      response.body
    end

    def connection(options={})
      # TODO: not to create on every request.
      Faraday.new(api_endpoint, options) do |faraday|
        faraday.adapter(adapter)
        faraday.request(:url_encoded)
        faraday.response(:xml, :content_type => "text/xml; charset=euc-jp")
        faraday.use(FaradayMiddleware::DMMRashify)
        faraday.use(FaradayMiddleware::ParseXml)
        faraday.use(Faraday::Response::RaiseDMMError)
      end
    end

    def encode_params!
      @params.each do |key, value|
        value.encode!(Encoding::EUC_JP) if value.is_a?(String) && !value.frozen?
      end
    end
  end
end
