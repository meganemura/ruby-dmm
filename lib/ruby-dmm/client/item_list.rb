# vim: ts=2 sts=2 et sw=2 ft=ruby
module DMM
  OPERATION_ITEM_LIST = 'ItemList'

  class Client
    module ItemList

      def item_list(keyword="", options={})
        @params = @params.merge(:keyword => keyword).merge(options)
        @params[:operation] = OPERATION_ITEM_LIST
        response = get('/', @params)
        return DMM::Response.new(response[:response])
      end
      alias :items :item_list

      [:service,
       :floor,
       :hits,
       :offset,
       :sort,
       :keyword,
       :mono_stock].each do |key|
        next if method_defined?(key)
        define_method(key) do |value|
          self.tap {|o| o.params.update(key => value) }
        end
      end
      alias :limit :hits
      alias :stock :mono_stock
    end
  end
end
