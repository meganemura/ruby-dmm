# vim: ts=2 sts=2 et sw=2 ft=ruby fileencoding=utf-8
require "spec_helper"

describe DMM::Response::Item do
  before :all do
    stub_get.to_return(xml_response("com.xml"))
    @item = DMM::new.item_list.result.items.first
  end

  describe '#images' do
    subject { @item.images }
    it { should be }
    its([:list])  { should == 'http://pics.dmm.com/mono/movie/n_616dlr22659/n_616dlr22659pt.jpg' }
    its([:small]) { should == 'http://pics.dmm.com/mono/movie/n_616dlr22659/n_616dlr22659ps.jpg' }
    its([:large]) { should == 'http://pics.dmm.com/mono/movie/n_616dlr22659/n_616dlr22659pl.jpg' }
  end

  describe 'define alias methods' do
    subject do
      item = DMM::Response::Item::ALIAS_METHOD_MAP.keys.inject({}) {|h, key| h.merge(key => 1) }
      DMM::Response::Item.new(item)
    end
    DMM::Response::Item::ALIAS_METHOD_MAP.values.each do |name|
      it { should respond_to(name) }
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

  describe 'define method for any keys' do
    subject do
      item = {
        :not_defined_key => true,
      }
      DMM::Response::Item.new(item)
    end
    it { should respond_to(:not_defined_key) }
  end
end
