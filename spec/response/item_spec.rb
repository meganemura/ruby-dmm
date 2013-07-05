# vim: ts=2 sts=2 et sw=2 ft=ruby fileencoding=utf-8
require "spec_helper"

describe DMM::Response::Item do
  before :all do
    stub_get.to_return(xml_response("r18.xml"))
    @item = DMM::new.item_list.result.items.first
    # pp @item.raw_item.iteminfo
    # pp @item.iteminfo.keywords
    pp @item.iteminfo.series

  end

  describe 'methods which returns integer' do
    subject { @item }
    DMM::Response::Item::ITEM_KEYS.each do |key|
      it { should respond_to(key) }
    end
  end
end
