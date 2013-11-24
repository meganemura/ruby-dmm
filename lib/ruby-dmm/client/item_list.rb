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
        end
      end

      alias :limit :hits
      alias :order :sort
      alias :stock :mono_stock
    end

  end
end
