extends Node2D

func on_beat_advance():
	var pizza = $"Pizza"
	var beam = $"Beam"
	beam.rotation = pizza.properties.get_beat_angle(Timelord.back_beat()+(1&Timelord.measure))
	beam.radians_ps = (1 - 2*(1&Timelord.measure)) * (pizza.properties.angle / Timelord.tempo.division) / Timelord.interval()

func _ready():
	Timelord.advance_beat.connect(on_beat_advance)
	Timelord.pause_rythm.connect(on_beat_advance.bind(0))
