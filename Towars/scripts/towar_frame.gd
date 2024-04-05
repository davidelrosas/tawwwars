extends StaticBody2D

@export var towar_type : Towar.towar_type
var towar

func _ready():
	set_data(0,1)

func _input(event):
	if event.is_action_pressed("ActionSet1"):
		action_interface()

func set_data(type : Towar.towar_type, model_id):
	var towar_subc = load(Towar.script_paths[type])
	towar = towar_subc.new(model_id)
	
	$HealthBar.max_value = towar.max_health
	$HealthBar.value = towar.current_health
	$Sprite2D.texture = towar.metadata[model_id]["Sprite"]
	
func effect_interface(attack : HealthEffect):
	towar.effect(attack)
	$HealthBar.value = towar.current_health
	pass


func action_interface():
	towar.action($".")
	pass
	
