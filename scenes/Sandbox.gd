extends Node2D

var towar = preload("res://Towars/prefabs/turret.tscn")
var healer = preload("res://Towars/prefabs/healer.tscn")

func _ready():
	$spawner.enemy_target.current = $Obelisk
	
	#target of the spawner set on specific lvl


func _input(event):
	if event.is_action_pressed("Up"):
		var new_towar = healer.instantiate()
		new_towar.position = get_viewport().get_mouse_position()
		add_child(new_towar)
