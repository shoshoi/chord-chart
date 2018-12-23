class Chord
  include ActiveModel::Model
  include Virtus.model

  attr_reader :degree
  attribute :root, Pitch, default: nil
  attribute :chord_name, String, default: nil

  def initialize(pitch_name, chord_name=nil)
    Rails.logger.debug "Chord#initialize(#{pitch_name}, #{chord_name})"
    pitch_name, chord_name = Chord.format_name(pitch_name, chord_name)
    set_member(pitch_name, chord_name)
  end

  def set_member(pitch_name, chord_name="")
    Rails.logger.debug "Chord#set_member(#{pitch_name}, #{chord_name})"
    self.root = Pitch.get(pitch_name)
    @chord_name = chord_name
    @degree = @@setting.chords.send(@chord_name).degree
  end

  def chord_name
    @chord_name
  end 

  def full_name
    self.root.pitch_name + self.chord_name
  end

  def short_name
    self.root.pitch_name + @@setting.chords.send(chord_name).name.first
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

  class << self
    @@setting = Hashie::Mash.load("config/general/setting.yml")
    @@chords = []
    
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
        if @@setting.signatures.keys.include?(full_name[1])
          pitch_name = full_name[0..1]
        else
          pitch_name = full_name[0]
        end

        pitch_len = pitch_name.length
        chord_len = full_name.length - pitch_len
        chord_short_name = full_name[pitch_len, chord_len]
        chord_name = @@setting.chords.find {|name, value| value.name.include?(chord_short_name) }.first
      end
      return pitch_name, chord_name
    end
  end
end
