# encoding: utf-8

require 'ruby-dmm/client'

module DMM
  def self.new(options = {})
    DMM::Client.new(options)
  end
end
