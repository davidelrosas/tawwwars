extends Node

var measure : int = 0
var beat : int = 0
var subbeat : int = 0

var tempo : Tempo

var subdivisions : PackedByteArray = [1,1,1,1]

signal beat_change()

func _ready():
	set_process(false)

func is_paused() -> bool:
	return !is_processing()

func get_swing_multiplier(beat_in : int):
	return 2*((1-tempo.swing) if 1 & beat_in else tempo.swing)

func sync(tempo_in : Tempo):
	self.tempo = tempo_in
	subdivisions.resize(tempo.division)
	subdivisions.fill(1)
	if !InputManager.pause_play.is_connected(on_pause_play):
		InputManager.pause_play.connect(on_pause_play)
	beat_change.emit()

func interval() -> float:
	return 60 as float / tempo.bpm as float * get_swing_multiplier(beat)

func sub_interval() -> float:
	return interval() / subdivisions[beat] as float

func to_closest_subbeat() -> float:
	var halftime = sub_interval() / 2
	return int(elapsed >halftime) * (halftime*2-elapsed) - int(elapsed <= halftime) * elapsed

var elapsed : float = 0
	
func on_pause_play():
	if !(is_processing() || (measure | beat | subbeat) || elapsed):
		advance_subbeat.emit()
		advance_beat.emit()
	set_process(!is_processing())
	
func from_the_top():
	measure = 0
	beat = 0
	subbeat = 0
	elapsed = 0
	
func _process(delta):
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
