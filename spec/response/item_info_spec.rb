# vim: ts=2 sts=2 et sw=2 ft=ruby fileencoding=utf-8
require "spec_helper"

describe DMM::Response::ItemInfo do

  def complex_hash
    {
      "actor"=> [
        {"name" => "ダニエル・ラドクリフ",  "id" => "60257"},
        {"name" => "だにえるらどくりふ",    "id" => "60257_ruby"},
        {"name" => "ルパート・グリント",    "id" => "60458"},
        {"name" => "るぱーとぐりんと",      "id" => "60458_ruby"},
        {"name" => "リチャード・ハリス",    "id" => "61833"},
        {"name" => "りちゃーどはりす",      "id" => "61833_ruby"},
        {"name" => "エマ・ワトソン",        "id" => "60074"},
        {"name" => "えまわとそん",          "id" => "60074_ruby"},
      ],
    }
  end

  describe '.integrate' do
    subject { DMM::Response::ItemInfo.new(complex_hash) }
    its(:actors) { should_not be_empty }
    describe 'actors' do
      it 'integrates name and ruby by id' do
        actor = subject.actors.find {|actor| actor["id"] == "60257" }
        actor["name"].should == "ダニエル・ラドクリフ"
        actor["ruby"].should == "だにえるらどくりふ"

        actor = subject.actors.find {|actor| actor["id"] == "60074" }
        actor["name"].should == "エマ・ワトソン"
        actor["ruby"].should == "えまわとそん"
      end
    end
  end


  describe 'define method for any keys' do
    subject do
      iteminfo = complex_hash
      DMM::Response::ItemInfo.new(iteminfo)
    end
    it { should be }
  end
end
