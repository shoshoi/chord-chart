class Chord
  include ActiveModel::Model
  include Virtus.model

  attr_reader :degree
  attribute :root, Pitch, default: nil
  attribute :chord_name, String, default: nil
  attribute :absolute_degree, Array, default: Array.new
  attribute :relative_degree, Array, default: Array.new

  def initialize(pitch_name, chord_name=nil)
    Rails.logger.debug "Chord#initialize(#{pitch_name}, #{chord_name})"
    pitch_name, chord_name = Chord.format_name(pitch_name, chord_name)
    set_member(pitch_name, chord_name)
  end

  def set_member(pitch_name, chord_name="")
    Rails.logger.debug "Chord#set_member(#{pitch_name}, #{chord_name})"
    @root = Pitch.get(pitch_name)
    @chord_name = chord_name
    @relative_degree = Settings.chords.send(@chord_name).degree
    @absolute_degree = @relative_degree.map {|degree| (@root.pitch_class + degree) % 12 }
  end

  def chord_name
    @chord_name
  end 

  def full_name
    @root.pitch_name + @chord_name
  end

  def short_name
    @root.pitch_name + Settings.chords.send(chord_name).name.first
  end

  def unizon
    Pitch.get(@absolute_degree[0])
  end

  def third
    Pitch.get(@absolute_degree[1])
  end

  def fifth
    Pitch.get(@absolute_degree[2])
  end

  def seventh
    Pitch.get(@absolute_degree[3])
  end

  def nineth
    Pitch.get(@absolute_degree[4])
  end

  def tarnspose(i=0)

  end

  def transpose!(i=0)

  end

  class << self
    @@chords = Array.new
    
    # Chordオブジェクトを生成する
    def get(pitch_name, chord_name=nil)
      Rails.logger.debug "Chord#self.get(#{pitch_name}, #{chord_name})"
      pitch_name, chord_name = Chord.format_name(pitch_name, chord_name)
      find_chord_name = pitch_name + chord_name

      # 同名コードは1つのインスタンスを使い回す
      unless found_chord = @@chords.find {|chord| chord.full_name == find_chord_name }
        found_chord = Chord.new(pitch_name, chord_name)
        @@chords.push(found_chord)
      end
      found_chord
    end

    def format_name(pitch_name, chord_name=nil)
      if chord_name.blank?
        full_name = pitch_name
        # pitch_name,chord_nameを再設定する
        if Settings.signatures.keys.find {|signature| signature.to_s == full_name[1] }
          pitch_name = full_name[0..1]
        else
          pitch_name = full_name[0]
        end

        pitch_len = pitch_name.length
        chord_len = full_name.length - pitch_len
        chord_short_name = full_name[pitch_len, chord_len]
        chord_name = Settings.chords.find {|name, value| value.name.include?(chord_short_name) }.first
      end
      return pitch_name.to_s, chord_name.to_s
    end
  end
end
