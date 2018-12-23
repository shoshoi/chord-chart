require 'rails_helper'

RSpec.describe ChordChart, type: :model do
  describe '#initialize' do
    before do
      @chart = ChordChart.new
    end
    context '引数がないとき' do
      it "key=Cmajorで生成される" do
        expect(@chart.key).to eq Chord.get("C")
        expect(@chart.root).to eq Pitch.get("C")
        expect(@chart.scale).to eq "major"
      end
    end
    context '引数がAmのとき' do
      it "key=Aminorで生成される" do
        @chart = ChordChart.new("Am")
        expect(@chart.key).to eq Chord.get("Am")
        expect(@chart.root).to eq Pitch.get("A")
        expect(@chart.scale).to eq "minor"
      end
    end
  end
  describe "#add" do
    before do
      @chart = ChordChart.new("C")
    end
    context '引数がChordのとき' do
      it "仕様未決定" do
        pending "仕様未決定"
        @chart.add([Chord.get("C"), Chord.get("D"), Chord.get("E") ,Chord.get("F")])
        expect(@chart.children).to eq []
      end
    end
  end
end
