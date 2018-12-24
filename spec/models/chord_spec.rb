require 'rails_helper'
RSpec.describe Chord, type: :model do
  describe 'self#get(pitch_name, chord_name)' do
    context '引数1が"C",引数2がnilのとき' do
      it "Cメジャーのオブジェクトが生成されること" do
        @chord = Chord.get("C")
        expect(@chord.root).to eq Pitch.get("C")
        expect(@chord.relative_degree).to eq [0, 4, 7]
        expect(@chord.chord_name).to eq "major"

        @chord = Chord.get("C")
        expect(@chord.root).to eq Pitch.get("C")
        expect(@chord.relative_degree).to eq [0, 4, 7]
        expect(@chord.chord_name).to eq "major"
      end 
    end
    context '引数1が"C#",引数2がnilのとき' do
      it "C#メジャーのオブジェクトが生成されること" do
        @chord = Chord.get("C#")
        expect(@chord.root).to eq Pitch.get("C#")
        expect(@chord.relative_degree).to eq [0, 4, 7]
        expect(@chord.chord_name).to eq "major"

        @chord = Chord.get("C#")
        expect(@chord.root).to eq Pitch.get("C#")
        expect(@chord.relative_degree).to eq [0, 4, 7]
        expect(@chord.chord_name).to eq "major"
      end 
    end
  end
  describe '#initialize(pitch_name, chord_name)' do
    context '引数1が"C",引数2がnilのとき' do
      it "Cメジャーのオブジェクトが生成されること" do
        @chord = Chord.new("C")
        expect(@chord.root).to eq Pitch.get("C")
        expect(@chord.relative_degree).to eq [0, 4, 7]
        expect(@chord.chord_name).to eq "major"
      end 
    end 
    context '引数1が"Cm",引数2がnilのとき' do
      it "Cマイナーのオブジェクトが生成されること" do
        @chord = Chord.new("Cm")
        expect(@chord.root).to eq Pitch.get("C")
        expect(@chord.relative_degree).to eq [0, 3, 7]
        expect(@chord.chord_name).to eq "minor"
      end
    end
    context '引数1が"C",引数2が"major"のとき' do
      it "Cメジャーのオブジェクトが生成されること" do
        @chord = Chord.new("C", "major")
        expect(@chord.root).to eq Pitch.get("C")
        expect(@chord.relative_degree).to eq [0, 4, 7]
        expect(@chord.chord_name).to eq "major"
      end
    end
    context '引数1が"C",引数2が"minor"のとき' do
      it "Cマイナーのオブジェクトが生成されること" do
        @chord = Chord.new("C", "minor")
        expect(@chord.root).to eq Pitch.get("C")
        expect(@chord.relative_degree).to eq [0, 3, 7]
        expect(@chord.chord_name).to eq "minor"
      end
    end
  end
  describe '#transpose(i)' do
    context 'コードがCメジャー,引数1が2のとき' do
      it "Dメジャーのオブジェクトが生成されること" do
        @chord = Chord.new("C")
        expect(@chord.transpose(2)).to eq Chord.get("D")
      end 
    end 
  end
  describe '#transpose!(i)' do
    context 'コードがCメジャー,引数1が2のとき' do
      it "Dメジャーのオブジェクトが生成されること" do
        pending "未実装"
        @chord = Chord.new("C")
        @chord.transpose!(2)
        expect(@chord).to eq Chord.get("D")
      end 
    end 
  end 
end
