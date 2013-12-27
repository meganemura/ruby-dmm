# vim: ts=2 sts=2 et sw=2 ft=ruby fileencoding=utf-8
require "spec_helper"

describe DMM::Response do
  before :all do
    stub_get.to_return(xml_response("com.xml"))
    @response = DMM.new.item_list
  end

  describe "Response" do
    subject { @response }
    it { should respond_to(:request) }
    it { should respond_to(:result) }
    its(:request) { should be_a(Hash) }
    its(:result)  { should be_a(DMM::Response::Result) }
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
      its(:items) { should be_an(Array) }
      specify do
        subject.items.each do |item|
          item.should be_a(DMM::Response::Item)
        end
      end
    end

    context "items.size == 0" do
      before do
        stub_get.to_return(xml_response("zero_items.xml"))
        @result = DMM.new.item_list.result
      end

      subject { @result }
      its(:items) { should be_an(Array) }
      specify do
        subject.items.size.should == 0
      end
    end
  end

  describe 'instance methods' do
    subject { @result }
    (DMM::Response::Result::RESULT_KEYS - [:items]).each do |key|
      it { should respond_to(key) }
      its(key) { should be_a(Integer) }
    end
  end
end
