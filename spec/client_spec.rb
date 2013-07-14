# vim: ts=2 sts=2 et sw=2 ft=ruby fileencoding=utf-8
require "spec_helper"

describe DMM::Client do
  describe ".item_list" do
    fixtures.each do |fixture|
      it "returns response for #{fixture.split('.').first}" do
        stub_get.to_return(xml_response(fixture))
        @item_list = DMM::Client.new.item_list
        @item_list.should_not be_nil
      end
    end
  end
end
