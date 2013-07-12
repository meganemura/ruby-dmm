# encoding: utf-8
require 'ruby-dmm/response/item_info'

module DMM
  class Response
    class Item
      ITEM_KEYS  = [
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
      attr_reader *ITEM_KEYS
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
        ITEM_KEYS.each do |key|
          instance_variable_set("@#{key}", item[key])
        end
        @date   = Time.parse(item[:date])

        if item[:prices]
          @price        = item[:prices][:price]
          @list_prices  = item[:prices][:list_price]
          @price_all    = item[:prices][:price_all]
          @prices       = item[:prices][:deliveries] && [item[:prices][:deliveries][:delivery]].flatten.inject({}) do |hash, params|
            hash.merge(params[:type] => params[:price].to_i)
          end
        end

        if item[:sample_image_url]
          @small_images = item[:sample_image_url][:sample_s][:image]
          @large_images = @small_images.map {|image| image.gsub(/(-[0-9]+\.jpg)/, 'jp\1') }
        end

        @iteminfo = ItemInfo.new(item[:iteminfo])
      end
    end
  end
end
