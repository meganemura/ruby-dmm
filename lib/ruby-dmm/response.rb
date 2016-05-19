# encoding: utf-8

require 'active_support/core_ext/hash/keys'

module DMM
  class Response
    def initialize(faraday_response)
      @original_response = faraday_response
    end

    attr_reader :original_response

    def body
      @body ||= original_response.body.deep_symbolize_keys
    end

    def headers
      original_response.headers
    end

    def status
      original_response.status
    end

    def result
      body[:result]
    end
  end
end
