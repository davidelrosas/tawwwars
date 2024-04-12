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
<<<<<<< HEAD
	beam.rps = pizza.angle / (pizza.division * pizza.interval * TAU * (-2 * int(pizza.reverse)+1))
=======
	beam.set_speed(pizza.bpm / pizza.get_swing_multiplier() * (int(pizza.reverse) * -2 + 1) * pizza.angle/TAU, pizza.division)
>>>>>>> 8a42e7c (added rythm pizza and manapool, which combines it with beam)

func _process(delta):
	pass
