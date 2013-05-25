# vim: ts=2 sts=2 et sw=2 ft=ruby

module DMM

  class Response
  end

  module Request
    def parameters
      self[:parameters][:parameter].inject(DMMRash.new) {|hash, params| hash[params[:name]] = params[:value]; hash }
    end
  end

  module Result
    def items
      self[:items][:item].each do |item|
        item.extend(DMM::Item)

        item.prices.extend(DMM::Item::Price)
        item.sample_image_url.extend(DMM::Item::SampleImageUrl)
        item.iteminfo.extend(DMM::Item::ItemInfo)
      end
    end
  end

  module Item
    def item_info; self[:iteminfo]; end

    module Price
      def deliveries
        self[:deliveries][:delivery].inject(DMMRash.new) {|hash, deliveries| hash[deliveries[:type]] = deliveries[:price]; hash }
      end
    end

    module SampleImageUrl
      def small_images
        self[:sample_s][:image]
      end

      def large_images
        self[:sample_s][:image].map {|image| image.gsub(/(-[0-9]+\.jpg)/, 'jp\1') }
      end
    end

    module ItemInfo
      def keywords; self[:keyword]; end
    end
  end

  private
  def integrate(list_of_hash, key_name, value_name)
    list_of_hash.inject(DMMRash.new) do |dst, src|
      key   = src[key_name]
      value = src[value_name]
      dst[key] = value
      dst
    end
  end
end
