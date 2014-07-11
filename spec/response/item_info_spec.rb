# vim: ts=2 sts=2 et sw=2 ft=ruby fileencoding=utf-8
require "spec_helper"

describe DMM::Response::ItemInfo do

  def complex_hash
    {
      "actor" => [
        {"name" => "ダニエル・ラドクリフ",  "id" => "60257"},
        {"name" => "だにえるらどくりふ",    "id" => "60257_ruby"},
        {"name" => "メガネ君",              "id" => "60257_classify"},
        {"name" => "ルパート・グリント",    "id" => "60458"},
        {"name" => "るぱーとぐりんと",      "id" => "60458_ruby"},
        {"name" => "リチャード・ハリス",    "id" => "61833"},
        {"name" => "りちゃーどはりす",      "id" => "61833_ruby"},
        {"name" => "エマ・ワトソン",        "id" => "60074"},
        {"name" => "えまわとそん",          "id" => "60074_ruby"},
      ],
    }
  end

  def simple_hash
    {
      "label"  => {"name" => "ワーナー・ホーム・ビデオ",  "id" => "60016"},
      "genre"  => {"name" => "ファンタジー",              "id" => "71009"},
      "series" => {"name" => "ハリー・ポッター",          "id" => "60029"},
      "maker"  => {"name" => "ワーナー・ホーム・ビデオ",  "id" => "45578"},
    }
  end

  describe '.integrate' do
    context 'simple_hash' do
      subject { DMM::Response::ItemInfo.integrate(complex_hash["actor"]) }
      it 'integrates name and ruby and more (classify etc...) by id' do
        actor = subject.find { |a| a["id"] == "60257" }
        expect(actor["name"]).to     eq("ダニエル・ラドクリフ")
        expect(actor["ruby"]).to     eq("だにえるらどくりふ")
        expect(actor["classify"]).to eq("メガネ君")
      end
    end

    context 'simple_hash' do
      subject { DMM::Response::ItemInfo.integrate(simple_hash["label"]) }
      it 'runs collectry' do
        label = subject.first
        expect(label["id"]).to    eq("60016")
        expect(label["name"]).to  eq("ワーナー・ホーム・ビデオ")
      end
    end
  end

  describe 'define method for any keys' do
    context 'complex_hash' do
      subject { DMM::Response::ItemInfo.new(complex_hash) }

      describe '#actors' do
        subject { super().actors }
        it { is_expected.not_to be_empty }
      end
      describe 'actors' do
        it 'integrates name and ruby by id' do
          actor = subject.actors.find { |a| a["id"] == "60257" }
          expect(actor["name"]).to     eq("ダニエル・ラドクリフ")
          expect(actor["ruby"]).to     eq("だにえるらどくりふ")
          expect(actor["classify"]).to eq("メガネ君")

          actor = subject.actors.find { |a| a["id"] == "60074" }
          expect(actor["name"]).to eq("エマ・ワトソン")
          expect(actor["ruby"]).to eq("えまわとそん")
        end
      end
    end

    context 'simple_hash' do
      subject do
        DMM::Response::ItemInfo.new(simple_hash)
      end
      it { is_expected.to be }

      describe 'director' do
        it 'respond to given keys' do
          simple_hash.keys.each do |key|
            expect(subject).to respond_to(key)
          end
        end
      end
    end
  end
end
