class ChordChart
  include ActiveModel::Model
  include Virtus.model
  
  attr_reader :degree
  attribute :key, Chord, default: nil 
  attribute :scale, String, default: nil
  attribute :children, Array, default: Array.new

  def initialize(key="C")
    @key = Chord.get(key)
    @scale = @key.chord_name
  end 

  def add(chord)
    self.children.push chord
    @children.flatten!
  end

  def root
    @key.root
  end
end
