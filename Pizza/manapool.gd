extends Node2D

func on_beat_advance():
	var pizza = $"Pizza"
	var beam = $"Beam"
	beam.rotation = pizza.pizza_properties.get_beat_angle(pizza.back_beat()+int(pizza.pizza_properties.is_beat_reverse()))
	beam.radians_ps = (1 - 2*int(pizza.pizza_properties.is_beat_reverse())) * (pizza.pizza_properties.angle / pizza.pizza_properties.division) / Timelord.interval()

func on_pause_play():
	var beam = $"Beam"
	beam.set_process(!beam.is_processing())

func _ready():
	Timelord.advance_beat.connect(on_beat_advance)
	Timelord.pause_rythm.connect(on_beat_advance.bind(0))
	InputManager.pause_play.connect(on_pause_play)
	$"Beam".set_process(Timelord.is_processing())
