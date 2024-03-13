extends Node2D

var rps : float = 3
var active_angle : float = PI/6
@export var working_range : float = 800

func set_bpm(bpm):
	rps = bpm / 60
	
func beam_normal() -> Vector2:
	return Vector2.from_angle(PI+rotation)

func angle_to(pos : Vector2) -> float:
	return beam_normal().angle_to(global_position-pos)

func in_zone(pos : Vector2) -> bool:
	
	return (abs(angle_to(pos)) <= active_angle) and (pos-global_position).length_squared() < working_range*working_range
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(PI * delta * rps)
	pass
