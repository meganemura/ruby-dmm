# vim: ts=2 sts=2 et sw=2 ft=ruby fileencoding=utf-8
require "spec_helper"

describe DMM::Response do
  before :all do
    stub_get.to_return(xml_response("com.xml"))
    @response = DMM.new.item_list
  end

  describe "Response" do
    subject { @response }
    it { is_expected.to respond_to(:request) }
    it { is_expected.to respond_to(:result) }

    describe '#request' do
      subject { super().request }
      it { is_expected.to be_a(Hash) }
    end

    describe '#result' do
      subject { super().result }
      it { is_expected.to be_a(DMM::Response::Result) }
    end
  end
end

describe DMM::Response::Result do
  before :each do
    stub_get.to_return(xml_response("com.xml"))
    @result = DMM.new.item_list.result
  end

  describe '#items' do
    context "items.size > 0" do
      subject { @result }

      describe '#items' do
        subject { super().items }
        it { is_expected.to be_an(Array) }
      end
      specify do
        subject.items.each do |item|
          expect(item).to be_a(DMM::Response::Item)
        end
      end
    end

    context "items.size == 0" do
      before do
        stub_get.to_return(xml_response("zero_items.xml"))
        @result = DMM.new.item_list.result
      end

      subject { @result }

      describe '#items' do
        subject { super().items }
        it { is_expected.to be_an(Array) }
      end
      specify do
        expect(subject.items.size).to eq(0)
      end
    end
  end

  describe 'instance methods' do
    subject { @result }
    (DMM::Response::Result::RESULT_KEYS - [:items]).each do |key|
      it { is_expected.to respond_to(key) }

      describe key do
        subject { super().send(key) }
        it { is_expected.to be_a(Integer) }
      end
    end
  end
end
