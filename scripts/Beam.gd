extends Node2D

@export_group("Beam Properties")
@export var active_angle : float = PI/6
@export var working_range : float = 800
@export var radius : float = 100

var radians_ps : float = 0

func set_rps(rps : float):
	radians_ps = TAU * rps
	
func beam_normal() -> Vector2:
	return Vector2.from_angle(PI+rotation)

func angle_to(pos : Vector2) -> float:
	return beam_normal().angle_to(global_position-pos)

func in_zone(pos : Vector2) -> bool:
	return (abs(angle_to(pos)) <= active_angle) and (pos-global_position).length_squared() < working_range*working_range
	
func _ready():
	$"Sprite2D".position = Vector2(radius,0)

func _process(delta):
	rotate(radians_ps * delta )
