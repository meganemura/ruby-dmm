require "spec_helper"

describe DMM::Client do
  before :all do
    client = DMM::Client.new("dummy_api_key", "dummy_affiliate_id")

    re = Regexp.compile(Regexp.escape(DMM::API_URL))
    stub_request(:any, re).
      to_return(File.new(File.expand_path(File.dirname(__FILE__) + "/data/dmm_com.xml")))
    @response = client.get({:keyword => "SearchKeyword"})
  end

  specify { @response.body.should have_key("response") }

  describe 'response' do
    subject { @response.body["response"] }
    it { should have_key("request") }
    it { should have_key("result") }
  end
end
