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
    set_member(pitch_name, chord_name)
  end

  def ==(chord)
    case chord
    when Chord
      self.full_name == chord.full_name
    else
      false
    end 
  end 

  def set_member(pitch_name, chord_name=nil)
    Rails.logger.debug "Chord#set_member(#{pitch_name}, #{chord_name})"
    pitch_name, chord_name = Chord.format_name(pitch_name, chord_name)
    @root = Pitch.new(pitch_name)
    @chord_name = chord_name
    @relative_degree = Settings.chords.send(@chord_name).degree
    @absolute_degree = @relative_degree.map {|degree| (@root.pitch_class + degree) % 12 }
  end

  def short_name
    @root.pitch_name + Settings.chords.send(chord_name).name.first
  end 
  alias_method :name, :short_name

  def full_name
    @root.pitch_name + @chord_name
  end 

  def chord_name
    @chord_name
  end 

  def degree_name(key)
    
  end

  def unizon
    Pitch.new(@absolute_degree[0])
  end

  def third
    Pitch.new(@absolute_degree[1])
  end

  def fifth
    Pitch.new(@absolute_degree[2])
  end

  def seventh
    Pitch.new(@absolute_degree[3])
  end

  def nineth
    Pitch.new(@absolute_degree[4])
  end

  def transpose(i=0)
    @root.transpose(i).chord(chord_name)
  end

  def transpose!(i=0)
    set_member(Pitch.new((@root + i) % 12).name, chord_name) 
  end

  class << self
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
