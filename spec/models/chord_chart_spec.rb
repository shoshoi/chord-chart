require 'rails_helper'

RSpec.describe ChordChart, type: :model do
  describe '正常系' do
    before do
      @chart = ChordChart.new
    end
    context 'newしたとき' do
      it "引数がなければ、key=Cmajで生成される" do
        expect(@chart.key).to eq "C"
        expect(@chart.root).to eq "C"
        expect(@chart.scale).to eq "major"
      end

      it "引数あり" do
        @chart = ChordChart.new("Am")
        expect(@chart.key).to eq "Am"
        expect(@chart.root).to eq "A"
        expect(@chart.scale).to eq "minor"
      end
    end
  end
  describe "メソッド" do
    before do
      @chart = ChordChart.new("C")
    end
    context "append" do
      it "値が格納されること" do
        @chart.append("C | F | G | Am")
        expect(@chart.inspect).to eq "C | F | G | Am"
      end
    end
    context "transpose" do
      before do
        @chart.append("C | F | G | Am")
      end
      it "移調されること" do
        @chart.transpose(2)
        expect(@chart.inspect).to eq "D | G | A | Bm"
      end
    end
  end
end
