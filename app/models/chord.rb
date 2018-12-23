class Chord
  @@setting = Hashie::Mash.load("config/general/setting.yml")
  @@chords = []
  @root = nil
  @degree = nil
  @chord_name

  def self.get(pitch_name, chord_name=nil)
    Rails.logger.debug "Chord#self.get(#{pitch_name}, #{chord_name})"
    pitch_name, chord_name = Chord.get_name(pitch_name, chord_name)
    find_chord_name = pitch_name + chord_name
    found_chord = @@chords.find {|chord| chord.chord_full_name == find_chord_name }
    if found_chord.blank?
      found_chord = Chord.new(pitch_name, chord_name)
      @@chords.push found_chord
    end
    found_chord
  end

  def self.get_name(pitch_name, chord_name=nil)
    if chord_name.blank?
      # pitch_name,chord_nameを再設定する
      if @@setting.signatures.keys.include?(pitch_name[1])
        reset_pitch_name = pitch_name[0..1]
      else
        reset_pitch_name = pitch_name[0]
      end 

      pitch_len = reset_pitch_name.length
      chord_len = pitch_name.length - reset_pitch_name.length
      chord_short_name = pitch_name[pitch_len, chord_len]
      reset_chord_name = @@setting.chords.find {|name, value| value.name.include?(chord_short_name) }.first

      pitch_name = reset_pitch_name
      chord_name = reset_chord_name
    end
    return pitch_name, chord_name
  end

  def initialize(pitch_name, chord_name=nil)
    Rails.logger.debug "Chord#initialize(#{pitch_name}, #{chord_name})"
    pitch_name, chord_name = Chord.get_name(pitch_name, chord_name)
    set_member(pitch_name, chord_name)
  end

  def set_member(pitch_name, chord_name="")
    Rails.logger.debug "Chord#set_member(#{pitch_name}, #{chord_name})"
    # コード文字列を分解
    @root = Pitch.get(pitch_name)
    @chord_name = chord_name
    @degree = @@setting.chords.send(@chord_name).degree
  end

  def chord_name
    @chord_name
  end 

  def chord_full_name
    @root.pitch_name + @chord_name
  end

  def root
    @root
  end

  def degree
    @degree
  end

  def unizon
    @root.interval(@degree[0])
  end

  def third
    @root.interval(@degree[1])
  end

  def fifth
    @root.interval(@degree[2])
  end

  def seventh
    @root.interval(@degree[3])
  end

  def nineth
    @root.interval(@degree[4])
  end

  def tarnspose(i=0)

  end

  def transpose!(i=0)

  end
end
