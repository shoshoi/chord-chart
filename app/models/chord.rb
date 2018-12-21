class Chord
  def key
    @key
  end
  def pitch
    @pitch
  end
  def signature
    @signature ||= ""
  end
  def scale
    @scale
  end
  def initialize(key=nil, chord=nil)
    @pitch_list = {
      "A": 0, "A#": 1, "Bb": 1, "B": 2, "Cb": 2, "B#":3, "C": 3, "C#":4, "Db":4, "D": 5,
      "D#": 6 ,"Eb": 6, "E": 7, "Fb":7, "F": 8, "F#": 9, "Gb": 9, "G": 10, "Ab": 10, "G#": 11, "Ab": 11}
    @signature_list = {"#": "sharp", "b": "flat"}
    @scale_list = {"M": "major", "m": "minor"}

    @key = key
    @pitch = chord[0]
    @signature = @signature_list[chord[1]] if @signature_list.keys.include?(chord[1])
    scale_start = @signature.blank? ? 1 : 2
    scale_str = chord[scale_start, chord.length - scale_start]
    scale_str = "M" if scale_str.blank?
    @scale = @scale_list[scale_str.to_sym]
  end
  def pitch_class
    root_pitch_class = @pitch_list[key.to_sym]
    pitch_class = @pitch_list[pitch.to_sym]
    if root_pitch_class > pitch_class
      relative_pitch_class = 12 - root_pitch_class + pitch_class
    else
      relative_pitch_class = pitch_class - root_pitch_class
    end
  end
end
