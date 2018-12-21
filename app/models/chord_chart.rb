class ChordChart
  prev = nil
  def key
    @key
  end
  def root
    @root
  end
  def scale
    @scale
  end

  def initialize(key=nil)
    @key = key || "C"
    @root = key || "C"
    @scale = "major"
Rails.logger.debug "none"
  end

  def initialize(key=nil, chord=nil)
    @key = key || "C" 
    @root = key || "C" 
    @scale = "major"
    Rails.logger.debug "1#{@key}#{chord}"
    @block = Block.new(@key, chord)
  end

  def set_chord(chord=nil)
    @block = Block.new(@key, chord)
  end

  def inspect
    @block.inspect
  end

end
