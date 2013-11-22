# vim: ts=2 sts=2 et sw=2 ft=ruby fileencoding=utf-8
require "spec_helper"

describe DMM::Response::Item do
  before :all do
    stub_get.to_return(xml_response("com.xml"))
    @item = DMM::new.item_list.result.items.first
  end

  describe 'methods which returns integer' do
    subject { @item }
    DMM::Response::Item::KEYS.each do |key|
      it { should respond_to(key) }
    end
  end

  describe '#large_images' do
    subject do
      item = {
        :sample_image_url => {
          :sample_s => {
            :image => ["http://pics.dmm.co.jp/digital/video/aaa00000/aaa00000-9.jpg"],
          },
        }
      }
      DMM::Response::Item.new(item)
    end
    its(:large_images) { should == ["http://pics.dmm.co.jp/digital/video/aaa00000/aaa00000jp-9.jpg"] }
  end
end
