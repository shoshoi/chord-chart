class ChordChart

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
    @blocks = []
  end

  def append(str)
    @blocks.push Block.new(@key, str)
  end

  def inspect
    @blocks.map {|block| block.inspect}
  end

end
