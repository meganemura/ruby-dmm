require 'faraday_middleware/response/mashify'
require 'rash'

# TODO Hash にする
module DMM
  class Rash < ::Hashie::Rash
    protected
    def underscore_string(str)
      str.to_s.strip.
        gsub(' ', '_').
        gsub(/::/, '/').
        gsub(/(URL)([a-z])/, '\1_\2').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        squeeze("_").
        downcase
    end
  end
end

module FaradayMiddleware
  # Public: Converts parsed response bodies to a Hashie::Rash if they were of
  # Hash or Array type.
  class DMMRashify < Mashify
    dependency do
      self.mash_class = DMM::Rash
    end
  end
end

# deprecated alias
Faraday::Response::DMMRashify = FaradayMiddleware::DMMRashify
