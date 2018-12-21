require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe '正常系' do
    before do
      @piece = Piece.new
    end 
    context 'newしたとき' do
      it "引数がなければ、key=Cmajで生成される" do
        expect(@chart.title).to eq "C" 
        expect(@chart.chord_charts).to eq "C" 
      end 
    end 
  end 
  describe "メソッド" do
    before do
      @chart = Piece.new("C")
    end
    context "append" do
      it "値が格納されること" do
        @chart.append("C | F | G | Am")
        expect(@chart.inspect).to eq "C | F | G | Am"
      end
    end
  end
end
