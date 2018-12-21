class Bar

  def initialize(key, chord)
    @key = key
    @chord = chord
    @pitch = [{pitch: 0, scale: "major"}]
  end

  def pitch
    @pitch
  end

end
