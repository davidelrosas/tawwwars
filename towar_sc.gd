extends Node

var towar = preload("res://structures/towar.tscn")

func _input(event):
	if event.is_action_pressed("click"):
		var new_towar = towar.instantiate()
		new_towar.position = get_viewport().get_mouse_position()
		add_child(new_towar)

