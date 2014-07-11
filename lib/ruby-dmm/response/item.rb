# encoding: utf-8
require 'ruby-dmm/response/item_info'

module DMM
  class Response
    class Item
      PREDEFINED_KEYS = [
        :date,
        :iteminfo,
        :list_price,
        :price,
        :price_all,
        :prices,
        :small_images,
      ]
      attr_reader(*PREDEFINED_KEYS)
      alias_method :item_info,  :iteminfo
      alias_method :info,       :iteminfo

      ALIAS_METHOD_MAP = {
        :bandaiinfo => :bandai_info,
        :cdinfo     => :cd_info,
        :image_url  => :images,
      }

      def initialize(item)
        item.each do |key, value|
          key = key.to_sym
          case key
          when :date
            @date = Time.parse(value) if value
          when :iteminfo
            @iteminfo = ItemInfo.new(value) if value
          when :sample_image_url
            @small_images = value[:sample_s][:image] if value
          when :prices
            setup_prices(value) if value
          else
            self.class.class_eval do
              unless method_defined?(key)
                attr_reader key
                if (name = ALIAS_METHOD_MAP[key.to_sym])
                  alias_method name, key.to_sym
                end
              end
            end
            instance_variable_set("@#{key}", item[key])
          end
        end
      end

      def large_images
        @small_images && @small_images.map do |image|
          image.gsub(/(-[0-9]+\.jpg)/, 'jp\1')
        end
      end

      private

      def setup_prices(prices)
        @price        = prices[:price]
        @list_prices  = prices[:list_price]
        @price_all    = prices[:price_all]
        @prices       = prices[:deliveries] && [prices[:deliveries][:delivery]].flatten.inject({}) do |hash, params|
          hash.merge(params[:type] => params[:price].to_i)
        end
      end
    end
  end
end
