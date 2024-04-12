extends Node2D

func _ready():
	SignalBus.advance_beat.connect(on_beat_advance)

func _input(event):
	if event.is_action_pressed("ActionSet1"):
		$"Pizza".from_the_top()

func on_beat_advance(beat : int):
	var pizza = $"Pizza"
	var beam = $"Beam"
	beam.rotation = pizza.get_beat_angle()
	beam.rps = pizza.angle / (pizza.division * pizza.interval * TAU * (-2 * int(pizza.reverse)+1))

func _process(delta):
	pass
