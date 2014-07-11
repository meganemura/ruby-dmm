# vim: ts=2 sts=2 et sw=2 ft=ruby fileencoding=utf-8
require "spec_helper"

describe DMM::Client do
  describe ".item_list" do
    fixtures.each do |fixture|
      it "returns response for #{fixture.split('.').first}" do
        stub_get.to_return(xml_response(fixture))
        @item_list = DMM::Client.new.item_list
        expect(@item_list).not_to be_nil
      end
    end
  end

  describe "#last_response" do
    before do
      stub_get.to_return(xml_response(random_fixture))
      @client = DMM::Client.new(:result_only => false)
      @item_list = @client.item_list
    end

    it "returns last response" do
      expect(@client.last_response).not_to be_nil
    end

    describe 'request params' do
      subject { @client.params }
      it { is_expected.not_to have_key(:result_only) }
    end

  end
end
