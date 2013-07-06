# encoding: utf-8
module DMM
  class Response
    class ItemInfo
      ATTRIBUTE_SINGLE   = [:series, :maker, :label, :director, :author, :type, :size, :genre, :color]
      ATTRIBUTE_MULTIPLE = {
        :keywords   => :keyword,
        :actresses  => :actress,
        :actors     => :actor,
        :artists    => :artist,
        :fighters   => :fighter,
      }
      attr_reader *ATTRIBUTE_SINGLE
      attr_reader *ATTRIBUTE_MULTIPLE.keys

      def initialize(item_info)
        ATTRIBUTE_SINGLE.inject({}) {|h,k| h.merge(k => k)}.merge({}).each do |attribute, key|
          value = self.class.integrate(item_info[key])
          value = value.first if value
          instance_variable_set("@#{attribute}", value)
        end
        ATTRIBUTE_MULTIPLE.each do |attribute, key|
          value = self.class.integrate(item_info[key])
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
