extends Resource
class_name pizza_properties

@export_category("rythm")
@export var division : int = 4
@export var swing : float = 0.5
@export var bpm : int = 120

@export_category("shape")
@export var angle : float = TAU
@export var inner_radius : int = 100
@export var radius : int = 200
@export var circle_res : int = 128

func get_swing_multiplier(beat : int):
	return (1&division) + int(!(1 & division)) * (2*((1-swing) if 1 & beat else swing))
	
func get_arc_num_points(radius_ : float, angle_: float)->int:
	return int(radius_==0) + int(radius_!=0)*(circle_res * (angle_ / angle) * (radius_/radius))
	
func is_full_circle():
	return is_equal_approx(angle,TAU)
	
func div_angle():
	return angle / division
