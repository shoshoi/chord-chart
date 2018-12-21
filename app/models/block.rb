class Block
  def initialize(obj)
    initialize(obj[0], obj[1])
  end

  def initialize(key, chord)
    @key = key
    @chords = chord.split("|").map {|chord| chord.strip }
    @bars = []
    @chords.each {|chord| @bars.push Bar.new(@key, chord) }
  end

  def inspect
    @bars.map {|bar| bar.pitch }
  end
end
