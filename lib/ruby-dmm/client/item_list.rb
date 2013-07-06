# encoding: utf-8
module DMM
  OPERATION_ITEM_LIST = 'ItemList'

  class Client
    module ItemList

      def item_list(keyword="", options={})
        @params = @params.merge(:keyword => keyword).merge(options)
        @params[:operation] = OPERATION_ITEM_LIST
        response = get('/', @params)
        item_list = DMM::Response.new(response[:response])
        @params[:result_only] ? item_list.result : item_list
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
      alias :order :sort
      alias :stock :mono_stock
    end
  end
end
