extends Node2D

var towar = preload("res://Towars/prefabs/turret.tscn")
var healer = preload("res://Towars/prefabs/healer.tscn")

func _ready():
	pass        
	#$spawner.enemy_target.current_targets.append($Healer)
	#we need to change spawner too
	
	#target of the spawner set on specific lvl


func _input(event):
	if event.is_action_pressed("Use"):
		var new_towar = healer.instantiate()
		new_towar.position = get_viewport().get_mouse_position()
		add_child(new_towar)
