# vim: ts=2 sts=2 et sw=2 ft=ruby fileencoding=utf-8
require "spec_helper"

describe DMM::Response::Item do
  before :all do
    stub_get.to_return(xml_response("com.xml"))
    @item = DMM::new.item_list.result.items.first
  end

  describe 'methods which returns integer' do
    subject { @item }
    DMM::Response::Item::ITEM_KEYS.each do |key|
      it { should respond_to(key) }
    end
  end
end
