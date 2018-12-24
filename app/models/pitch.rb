class Pitch
  include ActiveModel::Model
  include Virtus.model

  attribute :pitch_name, String, default: nil
  alias :name :pitch_name
  attribute :pitch_class, Integer, default: nil

  validates :pitch_name, presence: true
  validates :pitch_class, presence: true

  def initialize(pitch_name)
    Rails.logger.debug "Pitch#self.get(#{pitch_name})"
    @pitch_name = pitch_name
    @pitch_class = Settings.pitch.send(pitch_name).pitch_class
    if valid?
      # TODO:error
    end
  end 

  def interval(pitch_class)
    case pitch_class
    when Pitch
      (@pitch_class + pitch_class.pitch_class) % 12
    when Integer
      (@pitch_class + pitch_class) % 12
    else
      #TODO:error
    end
  end

  def chord(chord_name)
    Chord.get(@pitch_name, chord_name)
  end

  def major
    Chord.get(@pitch_name, "major")
  end

  def minor
    Chord.get(@pitch_name, "minor")
  end

  def transpose(pitch_class)
    Pitch.get((@pitch_class + pitch_class) % 12)
  end

  def inspect
    "pitch_name = #{@pitch_name} , @pitch_class = #{@pitch_class}"
  end
  
  class << self
    @@pitchs = Array.new

    def get(pitch_name)
      Rails.logger.debug "Pitch#self.get(#{pitch_name})"
      if pitch_name.is_a?(Integer)
        pitch_name = Settings.pitch.find {|name, value| pitch_name == value.pitch_class }.first
      end 

      unless found_pitch = @@pitchs.find {|pitch| pitch.pitch_name == pitch_name }
        found_pitch = Pitch.new(pitch_name)
        @@pitchs.push found_pitch
      end 
      found_pitch
    end 
  end
end
