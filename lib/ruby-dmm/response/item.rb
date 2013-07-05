# vim: ts=2 sts=2 et sw=2 ft=ruby
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
        :stock,
      ]
      attr_reader *ITEM_KEYS
      attr_reader *[
        :iteminfo,
        :price,
        :prices,
        :date,
        :small_images,
        :large_images,
      ]

      def initialize(item)
        ITEM_KEYS.each do |key|
          instance_variable_set("@#{key}", item[key])
        end

        @price  = item[:prices][:price]
        @prices = item[:prices][:deliveries][:delivery].inject({}) {|hash, params| hash.merge(params[:type] => params[:price].to_i) }
        @date   = Time.parse(item[:date])
        @small_images = item[:sample_image_url][:sample_s][:image]
        @large_images = @small_images.map {|image| image.gsub(/(-[0-9]+\.jpg)/, 'jp\1') }

        @iteminfo = ItemInfo.new(item[:iteminfo])

        @raw_item = item
      end
      alias :item_info :iteminfo
      attr_reader :prices
      attr_reader :raw_item

      def inspect
        %(#<#{self.content_id}: #{self.title}>)
      end
    end

    class ItemInfo
      attr_reader :raw
      ATTRIBUTE_SINGLE   = [:series, :maker, :label, :director]
      ATTRIBUTE_MULTIPLE = {:keywords => :keyword, :actresses => :actress}
      attr_reader *ATTRIBUTE_SINGLE
      attr_reader *ATTRIBUTE_MULTIPLE.keys

      def initialize(item_info)
        @raw = item_info
        ATTRIBUTE_MULTIPLE.each do |attribute, key|
          value = self.class.integrate(item_info[key])
          instance_variable_set("@#{attribute}", value)
        end
        ATTRIBUTE_SINGLE.inject({}) {|h,k| h.merge(k => k)}.merge({}).each do |attribute, key|
          value = self.class.integrate(item_info[key])
          value = value.first if value
          instance_variable_set("@#{attribute}", value)
        end
      end

      def self.integrate(h)
        h && [h].flatten.inject({}) {|hash, params|
          id, key = params["id"].split('_')
          hash[id] ||= {"id" => id}
          if key
            hash[id].merge!(key => params["name"])
          else
            hash[id].merge!("name" => params["name"])
          end
          hash
        }.values
      end
    end
  end
end
