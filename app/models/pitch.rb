class Pitch
  @@setting = Hashie::Mash.load("config/general/setting.yml")
  @@pitchs = []
  @pitch_name
  @pitch_class

  def self.get(pitch_name)
    Rails.logger.debug "Pitch#self.get(#{pitch_name})"
    if pitch_name.is_a?(Integer)
      pitch_name = @@setting.pitch.find {|name, value| pitch_name == value.pitch_class }.first
    end

    unless found_pitch = @@pitchs.find {|pitch| pitch.pitch_name == pitch_name }
      found_pitch = Pitch.new(pitch_name)
      @@pitchs.push found_pitch
    end 
    found_pitch
  end

  def initialize(pitch_name)
    Rails.logger.debug "Pitch#self.get(#{pitch_name})"
    @pitch_name = pitch_name
    @pitch_class = @@setting.pitch.send(pitch_name).pitch_class
  end 

  def pitch_name
    @pitch_name
  end

  def pitch_class
    @pitch_class
  end

  def interval(pitch_class)
    pitch_class = pitch_class.pitch_class if pitch_class.class == Pitch
    (@pitch_class + pitch_class) % 12
  end

  def chord(chord_name)
    Chord.get(@pitch_name, chord_name)
  end

  def inspect
    "pitch_name = #{@pitch_name} , @pitch_class = #{@pitch_class}"
  end
end
