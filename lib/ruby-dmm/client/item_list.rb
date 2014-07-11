# encoding: utf-8
module DMM
  OPERATION_ITEM_LIST = 'ItemList'.freeze

  class Client
    module ItemList
      def item_list(keyword = "", options = {})
        @params = @params.merge(:keyword => keyword).merge(options)
        @params[:operation] = OPERATION_ITEM_LIST
        response = get('/', @params)
        item_list = DMM::Response.new(response[:response])

        if @result_only
          item_list.result
        else
          item_list
        end
      end
      alias_method :items, :item_list

      ITEM_LIST_PARAMETERS = [
        :floor,
        :hits,
        :keyword,
        :mono_stock,
        :offset,
        :service,
        :sort,
      ].freeze

      ITEM_LIST_PARAMETERS.each do |key|
        next if method_defined?(key)

        define_method(key) do |value|
          @params.update(key => value)
          self
        end
      end

      alias_method :limit, :hits
      alias_method :order, :sort
      alias_method :stock, :mono_stock
    end
  end
end
