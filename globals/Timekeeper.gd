extends Node

var measure : int = 0
var beat : int = 0
var subbeat : int = 0
var paused : bool = true

var tempo : Tempo

var subdivisions : PackedByteArray = [1,1,1,1]

signal beat_change()

func _init():
	set_process(false)

func initialise(tempo : Tempo):
	self.tempo = tempo
	set_process(true)
	beat_change.emit()

func get_swing_multiplier(beat : int):
	return 2*((1-tempo.swing) if 1 & beat else tempo.swing)

func sync(tempo : Tempo):
	self.tempo = tempo
	subdivisions.resize(tempo.division)
	subdivisions.fill(1)
	beat_change.emit()

func interval() -> float:
	return 60 as float / tempo.bpm as float * get_swing_multiplier(beat)

func sub_interval() -> float:
	return interval() / subdivisions[beat] as float

func to_closest_subbeat() -> float:
	var halftime = sub_interval() / 2
	return int(elapsed >halftime) * (halftime*2-elapsed) - int(elapsed <= halftime) * elapsed

var elapsed : float = 0
	
func pause_play():
	if paused && tempo:
		paused = false
		if !(measure | beat | subbeat) && elapsed == 0:
			advance_beat.emit()
	else:
		paused = true
	
func from_the_top():
	measure = 0
	beat = 0
	subbeat = 0
	elapsed = 0
	paused = true
	pause_play()
	
func back_beat() -> int:
	return (int(1&measure)*(tempo.division-beat-1))+(int(1&~measure)*(beat))

func _process(delta):
	if (!paused):
		elapsed += delta
		if (elapsed >= sub_interval()):
			elapsed -= sub_interval()
			subbeat+=1
			if (subbeat == subdivisions[beat]):
				subbeat = 0
				beat+=1
				if (beat == tempo.division):
					beat = 0
					measure+=1
					advance_measure.emit()
				advance_beat.emit()
			advance_subbeat.emit()
	
signal advance_subbeat()

signal advance_beat()

signal advance_measure()

signal pause_rythm()
