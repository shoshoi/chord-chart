class ChordChart
  include ActiveModel::Model
  include Virtus.model
  
  attr_reader :degree
  attribute :key, Chord, default: nil 
  attribute :scale, String, default: nil
  attribute :children, Array

  def root
    @key.root
  end

  def initialize(key="C")
    @key = Chord.get(key)
    @scale = @key.chord_name
    @children = Array.new
  end 

  def add(chord)
    case chord
    when Array
      @children.push chord
    when String
      array = chord.split("|").map do |chord_str|
        chord_str.strip!
        chords = chord_str.split(" ")
        if chords.length == 1
          Chord.get(chords[0])
        else
          chart = ChordChart.new(@key.short_name)
          chart.add(chords.join("|"))
          chart
        end
      end
      @children.push array
    end
    @children.flatten!
  end

  def chart(level=0)
    chords = @children.map do |child|
      case child
      when ChordChart
        child.chart(level + 1)
      when Chord
        child.short_name
      end
    end
    case level
    when 0
      chords.join(" | ")
    when 1
      chords.join(" ")
    end
  end

  def change_key(pitch)
    if pitch.is_a?(String)
      pitch = Pitch.new(pitch)
    end 
    @children.map! do |child|
      case child
      when ChordChart
        child.key_change(pitch)
      when Chord
        child.transpose(@key.root.interval(pitch))
      end 
    end 
    @key = Chord.get(pitch.name, @scale)
  end

  def tonic

  end

  def supertonic

  end

  def mediant

  end

  def subdominant

  end

  def dominant

  end

  def submediant

  end

  def leadingtone

  end
end
