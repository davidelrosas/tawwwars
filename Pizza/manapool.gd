extends Node2D

func _ready():
	SignalBus.advance_beat.connect(on_beat_advance)
	SignalBus.pause_rythm.connect(on_beat_advance.bind(0))

func on_beat_advance(beat : int):
	var pizza = $"Pizza"
	var beam = $"Beam"
	beam.rotation = pizza.get_beat_angle(beat)
	beam.rps = pizza.get_rps()

func _process(delta):
	pass
