# encoding: utf-8
module DMM
  class Response
    class ItemInfo

      # for defining
      #   alias_method :actors, :actor
      PLURAL_MAP = {
        :actor    => :actors,
        :actress  => :actresses,
        :artist   => :artists,
        :author   => :authors,
        :color    => :colors,
        :director => :directors,
        :fighter  => :fighters,
        :genre    => :genres,
        :keyword  => :keywords,
        :label    => :labels,
        :maker    => :makers,
      }

      def initialize(item_info)
        item_info.each do |key, value|
          key = key.to_s
          value = self.class.integrate(value)
          self.class.class_eval do
            unless method_defined?(key)
              attr_reader key
              if plural = PLURAL_MAP[key.to_sym]
                alias_method plural, key.to_sym
              end
            end
          end
          instance_variable_set("@#{key}", value)
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
