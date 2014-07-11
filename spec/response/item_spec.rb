# vim: ts=2 sts=2 et sw=2 ft=ruby fileencoding=utf-8
require 'spec_helper'

describe DMM::Response::Item do
  before :all do
    stub_get.to_return(xml_response('com.xml'))
    @item = DMM.new.item_list.result.items.first
  end

  describe '#images' do
    subject { @item.images }
    it { is_expected.to be }

    describe '[:list]' do
      subject { super()[:list] }
      it { is_expected.to eq('http://pics.dmm.com/mono/movie/n_616dlr22659/n_616dlr22659pt.jpg') }
    end

    describe '[:small]' do
      subject { super()[:small] }
      it { is_expected.to eq('http://pics.dmm.com/mono/movie/n_616dlr22659/n_616dlr22659ps.jpg') }
    end

    describe '[:large]' do
      subject { super()[:large] }
      it { is_expected.to eq('http://pics.dmm.com/mono/movie/n_616dlr22659/n_616dlr22659pl.jpg') }
    end
  end

  describe 'define alias methods' do
    subject do
      item = DMM::Response::Item::ALIAS_METHOD_MAP.keys.inject({}) { |h, key| h.merge(key => 1) }
      DMM::Response::Item.new(item)
    end
    DMM::Response::Item::ALIAS_METHOD_MAP.values.each do |name|
      it { is_expected.to respond_to(name) }
    end
  end

  describe '#large_images' do
    subject do
      item = {
        :sample_image_url => {
          :sample_s => {
            :image => ['http://pics.dmm.co.jp/digital/video/aaa00000/aaa00000-9.jpg'],
          },
        }
      }
      DMM::Response::Item.new(item)
    end

    describe '#large_images' do
      subject { super().large_images }
      it { is_expected.to eq(['http://pics.dmm.co.jp/digital/video/aaa00000/aaa00000jp-9.jpg']) }
    end
  end

  describe 'define method for any keys' do
    subject do
      item = {
        :not_defined_key => true,
      }
      DMM::Response::Item.new(item)
    end
    it { is_expected.to respond_to(:not_defined_key) }
  end
end
