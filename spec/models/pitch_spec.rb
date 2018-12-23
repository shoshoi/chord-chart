require 'rails_helper'
RSpec.describe Pitch, type: :model do
  describe 'メソッド' do
    before do
      @pitch = Pitch.new("C")
    end

    context '#initialize(pitch_name)' do
      it '引数1が"C"のとき、Cのオブジェクトが生成されること' do
        expect(@pitch.pitch_name).to eq "C"
        expect(@pitch.pitch_class).to eq 0
      end 
    end 

    context '#interval(pitch_class)' do 
      it '引数1がPitchクラスのとき、インターバルが計算されること' do
        expect(@pitch.interval(Pitch.new("D"))).to eq 2
      end 

      it '引数1が数値のとき、インターバルが計算されること' do
        expect(@pitch.interval(2)).to eq 2
      end 
    end

    context '#major' do
      it "Cメジャーコードが生成されること" do
        expect(@pitch.chord("major")).to eq Chord.get("C", "major")
      end 
    end

    context '#minor' do
      it "Cマイナーコードが生成されること" do
        expect(@pitch.chord("minor")).to eq Chord.get("C", "minor")
      end
    end
  end
end
