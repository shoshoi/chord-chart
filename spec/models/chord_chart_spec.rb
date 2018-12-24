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
    context '引数がArray[Chord]のとき' do
      it "childrenに格納される" do
        @chart.add([Chord.get("C"), Chord.get("D"), Chord.get("E") ,Chord.get("F")])
        expect(@chart.children).to eq [Chord.get("C"), Chord.get("D"), Chord.get("E") ,Chord.get("F")]
      end
    end
    context '引数がStringのとき' do
      it "childrenに格納される" do
        @chart.add("C | D | E | F")
        expect(@chart.children).to eq [Chord.get("C"), Chord.get("D"), Chord.get("E") ,Chord.get("F")]
      end 
    end
    context '引数が入れ子のとき' do
      it "childrenに格納される" do
        @chart.add("C G | D | E | F")
        expect(@chart.chart).to eq "C G | D | E | F"
      end 
    end
  end

  describe "#chart" do
    before do
      @chart = ChordChart.new("C")
    end 
    context 'childrenがArray[Chord]のとき' do
      it "コード進行が出力される" do
        @chart.add([Chord.get("C"), Chord.get("D"), Chord.get("E") ,Chord.get("F")])
        expect(@chart.chart).to eq "C | D | E | F"
      end 
    end 
  end

  describe "#tonic" do
    before do
      @chart = ChordChart.new("C")
    end 
    context 'キーがCのとき' do
      it "コードCが出力される" do
        expect(@chart.tonic).to eq Chord.get("C")
      end 
    end 
  end

  describe "#supertonic" do
    before do
      @chart = ChordChart.new("C")
    end
    context 'キーがCのとき' do
      it "コードDmが出力される" do
        expect(@chart.supertonic).to eq Chord.get("Dm")
      end 
    end 
  end
  describe "#meiant" do
    before do
      @chart = ChordChart.new("C")
    end
    context 'キーがCのとき' do
      it "コードEmが出力される" do
        expect(@chart.mediant).to eq Chord.get("Em")
      end 
    end 
  end
  describe "#subdominant" do
    before do
      @chart = ChordChart.new("C")
    end
    context 'キーがCのとき' do
      it "コードFが出力される" do
        expect(@chart.subdominant).to eq Chord.get("F")
      end 
    end 
  end
  describe "#dominant" do
    before do
      @chart = ChordChart.new("C")
    end
    context 'キーがCのとき' do
      it "コードGが出力される" do
        expect(@chart.dominant).to eq Chord.get("G")
      end 
    end 
  end
  describe "#submediant" do
    before do
      @chart = ChordChart.new("C")
    end
    context 'キーがCのとき' do
      it "コードAが出力される" do
        expect(@chart.submediant).to eq Chord.get("Am")
      end 
    end
  end
  describe "#leadingtone" do
    before do
      @chart = ChordChart.new("C")
    end
    context 'キーがCのとき' do
      it "コードCが出力される" do
        expect(@chart.leadingtone).to eq Chord.get("Bm7-5")
      end 
    end 
  end
end
