class Block
  def initialize(key, bars_str)
    @key = key
    set_bars(bars_str)
  end

  def inspect
    @bars.map {|bar| bar.inspect }
  end

  def set_bars(bars_str=nil)
    bars_array = bars_str.split("|").map {|bar| bar.strip }    
    @bars = bars_array.map! do |bar_str|
      bar_str.split(" ").map do |chord| 
        Chord.new(@key, chord)
      end  
    end
  end
end
