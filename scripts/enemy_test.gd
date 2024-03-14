extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var beam = get_parent().get_node("Beam");
	var body = get_node("body")
	
	if beam.in_zone(body.position):
		body.rotation = PI
		body.apply_force(beam.position-position)
	else:
		body.rotation = 0
	pass
