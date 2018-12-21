require 'rails_helper'

RSpec.describe Bar, type: :model do
  describe '正常系' do
    before do
      @bar = Bar.new("C", "C")
    end 
    context 'newしたとき' do
      it "コードが相対に変換される" do
        expect(@bar.pitch).to eq [{pitch: 0, scale: "major"}]
      end
      it "複数でも変換される" do
        @bar = Bar.new("C", "C Dm")
        expect(@bar.pitch).to eq [{pitch: 0, scale: "major"}, {pitch: 2, scale: "minor"}]
      end
    end 
  end
end
