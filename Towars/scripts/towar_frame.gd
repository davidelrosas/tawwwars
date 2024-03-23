extends StaticBody2D

@export var towar_type : Towar.towar_type

var script_paths = {
	Towar.towar_type.attack_towar : "res://Towars/scripts/attack_towar_subclass.gd",
	Towar.towar_type.healing_towar : "res://Towars/scripts/healing_towar_subclass.gd",
	Towar.towar_type.defense_towar : "res://Towars/scripts/defense_towar_subclass.gd"
}

func _ready():
	
	$".".script = load(script_paths[towar_type])
	_ready()
		
