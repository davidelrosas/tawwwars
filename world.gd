extends Node

var towar = preload("res://Towars/prefabs/turret.tscn")
var healer = preload("res://Towars/prefabs/healer.tscn")

func _ready():
	var new_towar = towar.instantiate()
	new_towar.position = Vector2(300,100)
	add_child(new_towar)
	
	#target of the spawner set on specific lvl
