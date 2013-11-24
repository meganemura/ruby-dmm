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

    include DMM::Client::ItemList

    attr_accessor *Configuration::VALID_OPTIONS_KEYS
    attr_accessor :params

    def initialize(params={})
      DMM.options.each do |key, value|
        # fall back to `DMM::Configuration` module defaults
        send("#{key}=", params[key] || value)
      end

      # Symbolize keys
      params = params.inject({}) do |hash, (key, value)|
        hash.merge(key.to_sym => value)
      end

      @params = {
        :api_id       => ENV['DMM_API_ID']        || params[:api_id],       # your own api_id
        :affiliate_id => ENV['DMM_AFFILIATE_ID']  || params[:affiliate_id], # your own affiliate_id
        :operation    => nil,
        :version      => DEFAULT_API_VERSION,
        :timestamp    => Time.now.strftime("%F %T"),
        :site         => DEFAULT_SITE,
        :result_only  => false, # Set true to get response.result only.
      }.merge(params)
    end

    def operation(value)
      @params.update(:operation => value)
    end

    def all
      @params[:operation] ? get('/', @params) : nil
    end

    def last_response
      @last_response
    end

    private

    def get(path, options={})
      encode_params!
      @last_response = connection.get('/', options)
      @last_response.body
    end

    def connection(options={})
      # TODO: not to create on every request.
      connection = Faraday.new(api_endpoint, options) do |faraday|
        faraday.adapter(adapter)
        faraday.request(:url_encoded)
        faraday.response(:xml, :content_type => "text/xml; charset=euc-jp")
        faraday.use(FaradayMiddleware::DMMRashify)
        faraday.use(FaradayMiddleware::ParseXml)
        faraday.use(Faraday::Response::RaiseDMMError)
      end
      connection.headers[:user_agent] = user_agent
      connection
    end

    def encode_params!
      @params.each do |key, value|
        value.encode!(Encoding::EUC_JP) if value.is_a?(String) && !value.frozen?
      end
    end
  end
end
