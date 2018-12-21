class Piece
  @chord_charts = []
  def initialize(key=nil)
    @key = key || "C" 
    @root = key || "C" 
    @scale = "major"
  end
  def append(chord=nil)
    Rails.logger.debug "0#{@key}#{chord}"
    @chord_charts.push ChordChart.new(@key, chord)
  end
  def append(key=nil, chord=nil)
    Rails.logger.debug "0-#{@key}#{chord}"
    @chord_charts.push ChordChart.new(key, chord)
  end
  def inspect
    @chord_charts.map {|chart| chart.inspect }
  end
end
