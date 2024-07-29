extends Node2D

var allen = preload("res://Mobs/allen.tscn")

func _ready():
	pass
	#$spawner.enemy_target.current_targets.append($Healer)
	#we need to change spawner too
	
	#target of the spawner set on specific lvl


func _input(event):
	if event.is_action_pressed("click"):
		return
		var new_enemy = allen.instantiate()
		new_enemy.position = get_viewport().get_mouse_position()
		add_child(new_enemy)
