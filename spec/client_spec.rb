# vim: ts=2 sts=2 et sw=2 ft=ruby fileencoding=utf-8
require "spec_helper"

describe DMM::Client do
  before do
    @client = DMM::Client.new
  end

  describe ".item_list" do
    it "returns response" do
      stub_get.to_return(xml_response("r18.xml"))
      item_list = @client.item_list

      item_list.should_not be_nil
    end
  end
end
