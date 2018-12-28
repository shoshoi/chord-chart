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
      if pitch_name.is_a?(Integer)
        pitch_name = Settings.pitch.find {|name, value| pitch_name == value.pitch_class }.first
      end
    @pitch_name = pitch_name
    @pitch_class = Settings.pitch.send(pitch_name).pitch_class
    if valid?
      # TODO:error
    end
  end

  def ==(pitch)
    case pitch
    when Pitch
      self.pitch_class == pitch.pitch_class
    else
      false
    end
  end

  def <(pitch)
    case pitch
    when Pitch
      self.pitch_class < pitch.pitch_class
    else
      false
    end 
  end
 
  def <=(pitch)
    case pitch
    when Pitch
      self.pitch_class <= pitch.pitch_class
    else
      false
    end 
  end

  def >(pitch)
    case pitch
    when Pitch
      self.pitch_class > pitch.pitch_class
    else
      false
    end 
  end

  def >=(pitch)
    case pitch
    when Pitch
      self.pitch_class >= pitch.pitch_class
    else
      false
    end 
  end

  def +(pitch)
    case pitch
    when Pitch
      self.pitch_class += pitch.pitch_class
    when Integer
      self.pitch_class += pitch
    else
      # error
    end 
  end

  def -(pitch)
    case pitch
    when Pitch
      self.pitch_class -= pitch.pitch_class
    when Integer
      self.pitch_class -= pitch
    else
      # error
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
    Chord.new(@pitch_name, chord_name)
  end

  def major
    Chord.new(@pitch_name, "major")
  end

  def minor
    Chord.new(@pitch_name, "minor")
  end

  def transpose(pitch_class)
    Pitch.new((@pitch_class + pitch_class) % 12)
  end

  def inspect
    "pitch_name = #{@pitch_name} , @pitch_class = #{@pitch_class}"
  end
end
