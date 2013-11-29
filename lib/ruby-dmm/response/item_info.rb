# encoding: utf-8
module DMM
  class Response
    class ItemInfo
      SINGLE_VALUE_ATTRIBUTES   = [
        :author,
        :color,
        :director,
        :genre,
        :label,
        :maker,
        :series,
        :size,
        :type,
      ]
      MULTIPLE_VALUES_ATTRIBUTES = {
        :actors     => :actor,
        :actresses  => :actress,
        :artists    => :artist,
        :fighters   => :fighter,
        :keywords   => :keyword,
      }
      attr_reader *SINGLE_VALUE_ATTRIBUTES
      attr_reader *MULTIPLE_VALUES_ATTRIBUTES.keys

      def initialize(item_info)
        SINGLE_VALUE_ATTRIBUTES.inject({}) {|h,k| h.merge(k => k)}.merge({}).each do |attribute, key|
          value = self.class.integrate(item_info[key.to_s])
          value = value.first if value
          instance_variable_set("@#{attribute}", value)
        end
        MULTIPLE_VALUES_ATTRIBUTES.each do |attribute, key|
          value = self.class.integrate(item_info[key.to_s])
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
