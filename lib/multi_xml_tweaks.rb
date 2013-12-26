# encoding: utf-8
require 'multi_xml'

module MultiXml
  class << self

    def encoding_values(params, encoding = Encoding::UTF_8)
      case params
      when Hash
        params.inject({}) do |result, (key, value)|
          result.merge(key => encoding_values(value))
        end
      when String
        params.encode(encoding)
      when Array
        params.map { |v| encoding_values(v) }
      else
        params
      end
    end

    alias_method :original_parse, :parse
    def parse(xml, options = {})
      hash = original_parse(xml, options)
      encoding_values(hash)
    end

  end
end
