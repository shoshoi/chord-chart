class ChordChart
  @key = nil
  @children = []

  def initialize(key="C")
    @key = Chord.get(key)
    @scale = @key.chord_name
  end 

  def add(chord)
    @children ||= []
    @children.push chord
    @children.flatten!
  end

  def key
    @key
  end

  def root
    @key.root
  end

  def scale
    @scale
  end

  def children
    @children
  end
end
