# encoding: utf-8
require 'ruby-dmm/response/item_info'

module DMM
  class Response
    class Item
      KEYS  = [
        :title,
        :service_name,
        :floor_name,
        :category_name,
        :content_id,
        :product_id,
        :url,
        :affiliate_url,
        :affiliate_url_sp,
        :url_sp,
        :jancode,
        :maker_product,
        :stock,
        :bandaiinfo,
        :cdinfo,
        :isbn,
      ]
      attr_reader *KEYS
      attr_reader *[
        :iteminfo,
        :price,
        :prices,
        :price_all,
        :list_price,
        :date,
        :small_images,
        :large_images,
      ]
      alias :item_info    :iteminfo
      alias :bandai_info  :bandaiinfo
      alias :cd_info      :cdinfo

      def initialize(item)
        item.each do |key, value|
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
