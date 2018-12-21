class Block
  @chords
  def initialize(obj)
    initialize(obj[0], obj[1])
  end

  def initialize(key, bars_str)
    @key = key
    set_bars(bars_str)
  end

  def inspect
    @bars.map {|bar| bar.pitch }
  end

  def set_bars(bars_str=nil)
    bars_array = bars_str.split("|").map {|bar| bar.strip) }    
    bars_array.map! do |bar_str|
      bar_str.split.(" ").map {|chord| Chord.new(chord) }
    end
  end
end
