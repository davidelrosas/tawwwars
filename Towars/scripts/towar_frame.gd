extends StaticBody2D

@export var towar_model : Towar.towar_model
var towar

func _ready():
	set_data()

func _input(event):
	if event.is_action_pressed("ActionSet1"):
		action_interface()

func set_data():
	towar = Towar.new(Towar.towar_model.TURRET)
	get_meta(&"HealthComponent").set_health(towar.stats.max_health)

func action_interface():
	towar.action($".")
	pass
	
