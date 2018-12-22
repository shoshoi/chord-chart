require 'rails_helper'
pitch_data = [
  {
    key: "C",
    values: [
      {value: "C", result: 0 }, {value: "D", result: 2 }, {value: "E", result: 4 }, {value: "F", result: 5 },
      {value: "G", result: 7 }, {value: "A", result: 9 }, {value: "B", result: 11 },
    ]
  }
]
RSpec.describe Chord, type: :model do
  describe 'メソッド' do
    before do
      @chord = Chord.new("C","C")
    end
    context '#pitch_class' do
      pitch_data.each do |data|
        data[:values].each do |value|
          it "key=#{data[:key]} chord=#{value[:value]}のとき、音程#{value[:result]}を取得する" do
            @chord = Chord.new(data[:key], value[:value])
            expect(@chord.key).to eq data[:key]
            expect(@chord.interval).to eq value[:result]
          end
        end
      end
    end
    context "#methods" do
      it "kari" do
        @chord.tonic
        @chord.supertonic
        @chord.mediant
        @chord.subdominant
        @chord.dominant
        @chord.submediant
        @chord.leadingtone

        @chord.tonic?
        @chord.supertonic?
        @chord.mediant?
        @chord.subdominant?
        @chord.dominant?
        @chord.submediant?
        @chord.leadingtone?

        @chord.degree_number
        @chord.degree_name
        @chord.tarnspose(4)
        @chord.transpose!(4)
      end
    end
  end
end
