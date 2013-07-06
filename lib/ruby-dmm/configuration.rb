# encoding: utf-8
require 'faraday'
require "ruby-dmm/version"

module DMM

  module Configuration
    VALID_OPTIONS_KEYS = [
      :adapter,
      :user_agent,
      :api_endpoint,
    ].freeze

    DEFAULT_ADAPTER       = Faraday.default_adapter
    DEFAULT_USER_AGENT    = "ruby-dmm gem #{DMM::VERSION}".freeze
    DEFAULT_API_ENDPOINT  = ENV['DMM_API_ENDPOINT'] || 'http://affiliate-api.dmm.com'

    attr_accessor(*VALID_OPTIONS_KEYS)

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def options
      VALID_OPTIONS_KEYS.inject({}) {|h, k| h.merge!(k => send(k)) };
    end

    def api_endpoint=(value)
      @api_endpoint = File.join(value, "")
    end

    def reset
      self.adapter      = DEFAULT_ADAPTER
      self.user_agent   = DEFAULT_USER_AGENT
      self.api_endpoint = DEFAULT_API_ENDPOINT
    end
  end
end
