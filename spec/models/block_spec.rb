require 'rails_helper'

data = {
  value: ["C", "C Dm | G | F | G"],
  result: [
    [{pitch: 0, scale: "major"}, {pitch: 2, scale: "minor"}], {pitch: 7, scale: "major"},
     {pitch: 5, scale: "major"}, {pitch: 7, scale: "major"}
  ]
}
RSpec.describe Block, type: :model do
  describe '正常系' do
    before do
      @block = Block.new(data[:value])
    end
    context 'newしたとき' do
      it "コードが変換される" do
        expect(@block.inspect).to eq data[:result]
      end
    end
  end
end
