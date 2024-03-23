extends Node2D

const placeables = ["res://prefabs/slot.tscn","res://prefabs/spawner.tscn"]

var placed

var tmp

var placement_index : int = 0

func save(path : String):
	#n_spawners,spawner coordinates, n_slots, slot coordinates
	var file = FileAccess.open(path,FileAccess.WRITE)
	for p in placeables:
		file.store_32(placed[p].size())
		for o in placed[p]:
			file.store_float(o.x)
			file.store_float(o.y)
	file.close()
	
func _input(event):
	match event:
		InputEventMouseButton:
			match event.button_index:
				MOUSE_BUTTON_LEFT:
					
					pass
				MOUSE_BUTTON_RIGHT:
					placement_index = (placement_index + 1) % placeables.size()
					tmp = preload(placeables[0]).instantiate()
		InputEventMouseMotion:
			pass

func _ready():
	for p in placeables:
		placed[p] = []

func _process(delta):
	
	pass
