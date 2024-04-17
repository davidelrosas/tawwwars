class_name PizzaProperties
extends Resource

@export_category("shape")
@export var angle : float = TAU
@export var inner_radius : int = 100
@export var radius : int = 200
@export var circle_res : int = 128

func get_arc_num_points(radius_ : float, angle_: float)->int:
	return int(radius_==0) + int(radius_!=0)*(circle_res * (angle_ / angle) * (radius_/radius))
	
func is_full_circle():
	return is_equal_approx(angle,TAU)

func get_beat_angle(beat = Timelord.beat):
	return beat * angle/Timelord.tempo.division
	
func slice_angle():
	return angle / Timelord.tempo.division

func get_arc(radius,beat) -> PackedVector2Array:
	var num_points : int = get_arc_num_points(radius,slice_angle())
	var points : PackedVector2Array = PackedVector2Array()
	for x in range(num_points+1):
		points.push_back(Vector2(radius,0).rotated(slice_angle()*(float(x)/float(num_points)+beat)))
	return points
