require 'rails_helper'

RSpec.describe Chord, type: :model do
  describe '正常系' do
    before do
      @chord = Chord.new("C","C")
    end
    context 'newしたとき' do
      it "引数がなければ、key=Cmajで生成される" do
        expect(@chord.key).to eq "C"
        expect(@chord.pitch).to eq "C"
        expect(@chord.signature).to eq ""
        expect(@chord.scale).to eq "major"
        expect(@chord.pitch_class).to eq 0
      end
    end
  end
end
