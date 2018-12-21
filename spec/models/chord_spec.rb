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
          it "key=#{data[:key]} コード#{value[:value]}のとき、相対音程#{value[:result]}を取得する" do
            @chord = Chord.new(data[:key], value[:value])
            expect(@chord.key).to eq data[:key]
            expect(@chord.interval).to eq value[:result]
          end
        end
      end
    end
  end
end
