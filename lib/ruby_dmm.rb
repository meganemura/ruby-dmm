# encoding: utf-8

require_relative 'ruby_dmm/client'

module DMM
  def self.new(options = {})
    DMM::Client.new(options)
  end
end
