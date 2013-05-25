# vim: ts=2 sts=2 et sw=2 ft=ruby fileencoding=utf-8
require "spec_helper"

describe DMM::Client do
  re = Regexp.compile(Regexp.escape(DMM::API_URL))

  before :all do
    @client = DMM::Client.new('dummy_api_key', 'dummy_affiliate_id')
  end

  describe 'parameters' do
    describe 'methods for update parameters' do
      (DMM::Client::REQUIRED_KEYS + DMM::Client::OPTIONAL_KEYS).each do |key|
        describe "##{key}" do
          subject { @client.send(key, (@val = rand(100))) }

          it 'creates new instance' do
            subject.object_id.should_not == @client.object_id
          end
          it 'has updated parameters' do
            subject.params[key].should == @val
          end
          it 'doesn\'t update parameters of original client' do
            if @client.params[key]
              @client.params[key].should_not == @val
            end
          end
        end
      end
    end
  end


  describe '#order' do
    pending
  end


  describe 'private methos' do
    describe '#encode_params!' do
      before :all do
        @client.params = {:keyword => "日本語"}
        @client.send(:encode_params!)
      end
      it 'encode keyword parameter into euc-jp' do
        @client.params[:keyword].encoding.should == Encoding::EUC_JP
      end
    end
  end
end
