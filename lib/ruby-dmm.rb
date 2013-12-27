# encoding: utf-8
require "ruby-dmm/configuration"
require 'ruby-dmm/error'
require "ruby-dmm/client"

module DMM
  extend Configuration

  class << self
    def new(options = {})
      DMM::Client.new(options)
    end

    # Delegate to DMM::Client.new
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private = false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end
