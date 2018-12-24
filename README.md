# Usage
## Pitch
```
pitch = Pitch.get("C")
pitch.major             # => <Chord "C">
pitch.minor             # => <Chord "Cm">
pitch.transpose(2)      # => <Pitch "D">
pitch.interval("D")     # => <Integer 2>
```

## Chord
```
chord = Chord.get("C")
chord.name              # => <String "C">
chord.full_name         # => <String "Cmajor">

chord.root              # => <Pitch "C">
chord.unizon            # => <Pitch "C">
chord.third             # => <Pitch "E">
chord.fifth             # => <Pitch "G">

chord.transpose(2)      # => <Chord "D">
```

## ChordChart
```
chart = ChordChart.new
chart.add("C | F | G | Am")
chart.change_key("D")
chart.chart             # => <String "D | G | A | Bm">
```
