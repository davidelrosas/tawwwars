class_name PizzaProperties
extends Resource

@export_category("shape")
@export var angle : float = TAU
@export var inner_radius : int = 100
#@export var radius : float = 200
@export var circle_res : int = 128

<<<<<<< HEAD
@export_category("rythm")
@export var division : int = 4
@export var bpm : float = 120
@export var swing : float = 0.5

var subdivisions : PackedByteArray = [1,1,1,1]

func get_arc_num_points(radius : float, angle_: float)->int:
	return floori(circle_res as float * (angle_ / self.angle) * radius / 100)
=======
func get_arc_num_points(radius_ : float, angle_: float)->int:
	return int(radius_==0) + int(radius_!=0)*(circle_res as float * (angle_ / angle) * (radius_/radius))
>>>>>>> 2cf07bc0a87c746fe1911ea2e59f5adf6695a2e1
	
func is_full_circle():
	return is_equal_approx(angle,TAU)

func get_beat_angle(beat = Timelord.beat):
	return beat * angle/division
	
func get_swing_multiplier(beat : int):
	return 2*((1-swing) if 1 & beat else swing)
	
func interval(beat : int) -> float:
	return 60 as float / bpm as float * get_swing_multiplier(beat)
	
func sub_interval(beat : int) -> float:
	return interval(beat) / subdivisions[beat] as float
	
func selection_clampi(selector: Vector2i)->Vector2i:
	var x = mod_clamp_slice(selector.x)
	return Vector2i(
		x
		,clampi(selector.y,0, subdivisions[x]*2))
	
	
func slice_angle():
	return angle / division
	
func is_beat_reverse() -> bool:
	return !is_full_circle() && (1 & Timelord.measure)

func get_radius(slot : Vector2i)->float:
	return inner_radius + (slot.y as float * 100)
	#return lerp(100, radius, slot.y as float / subdivisions[slot.x])

func get_max_radius_x(slice_x : int) -> float:
	var x = mod_clamp_slice(slice_x)
	return get_radius(Vector2i(x,subdivisions[x]))

func mod_clamp_slice(slice_x : int) -> int:
	return (slice_x % division) if is_full_circle() else (clampi(slice_x,0,division-1))

func get_arc(slot : Vector2i):
	return get_arc_from_radius(get_radius(slot),slot.x)

@warning_ignore("shadowed_variable")
func get_arc_from_radius(radius:float,beat:int) -> PackedVector2Array:
	var num_points : int = get_arc_num_points(radius,slice_angle())
	var points : PackedVector2Array = PackedVector2Array()
	for x in range(num_points+1):
		points.push_back(Vector2(radius,0).rotated(slice_angle()*(float(x)/float(num_points)+beat)))
	return points
