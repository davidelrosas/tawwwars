extends Node2D

var slots : PackedInt64Array = [0]
var slot_flags : PackedByteArray = [2]
var beat : int = 0
var subbeat : int = -1
static var pizzaprops : pizza_properties
var interval : float = 0
static var reverse : bool = false

enum Slotflags {Selected = 1, Rest = 2, Towar = 4, Temporary = 8}

static func get_start_angle(beet : int) -> float:
	return pizzaprops.div_angle() * (beet+int(reverse))
	
func on_subdiv():
	queue_redraw()
	
func on_pause():
	subbeat = -1
	queue_redraw()

func get_arc(radius) -> PackedVector2Array:
	var num_points : int = pizzaprops.get_arc_num_points(radius,pizzaprops.div_angle())
	var points : PackedVector2Array = PackedVector2Array()
	for x in range(num_points+1):
		points.push_back(Vector2(0,-radius).rotated(pizzaprops.div_angle()*(float(x)/float(num_points)+beat)))
	return points

func _init(beet : int, pizza_props):
	beat = beet
	pizzaprops = pizza_props
	interval = 60 as float / pizzaprops.bpm * pizzaprops.get_swing_multiplier(beet)
	
func get_radius(subbeat : float):
	return lerp(100, pizzaprops.radius, subbeat/slots.size())
	
func get_rps():
	return pizzaprops.div_angle() / ( interval * TAU * (int(!reverse) - int(reverse)))

func elapse(elapsed : float) -> float:
	var tmp : int = floor(float(slots.size()) * (elapsed / interval))
	if (tmp > subbeat && subbeat < slots.size()):
		subbeat = tmp
		on_subdiv()
	if (elapsed >= interval):
		elapsed -= interval
		var next_beat : int = beat
		if ((!beat&&reverse) || (beat == pizzaprops.division-1 && !reverse)) && !pizzaprops.is_full_circle():
			reverse = !reverse
		else:
			next_beat = (next_beat+int(!reverse) - int(reverse)) % pizzaprops.division
		subbeat = -1
		SignalBus.advance_beat.emit(next_beat)
	return elapsed
	
func _draw():
	for x in range(slots.size()):
		var r_start = get_radius(x)
		var r_end = get_radius(x+1)
		var bottom_arc = get_arc(r_start)
		bottom_arc.reverse()   #polygon point order
		var top_arc = get_arc(r_end)
		var arccolor = Color(1,0,0).lerp(Color(0,1,0),x as float / slots.size() as float).lerp(Color(0,0,1),beat as float / pizzaprops.division as float)
		if (slot_flags[x] & Slotflags.Selected || subbeat == x):
			arccolor = arccolor.inverted()
		draw_colored_polygon(bottom_arc+top_arc,arccolor)
		draw_polyline(top_arc,Color(0,0,0),6,true)

func slot_insert(index, id, flags):
	slots.insert(index,id)
	slot_flags.insert(index,flags)
	
func slot_delete(index):
	slots.remove_at(index)
	slot_flags.remove_at(index)

func select(selector : int) -> int:
	var selection = clamp(selector,0,slots.size() * 2)
	if (!(1&selection)):
		slot_insert(selection/2,0,Slotflags.Selected | Slotflags.Temporary)
	else:
		slot_flags[selection/2] = Slotflags.Selected
	queue_redraw()
	return selection / 2

func deselect(index : int):
	if Slotflags.Temporary & slot_flags[index]:
		slot_delete(index)
	else:
		slot_flags[index] ^= Slotflags.Selected
	queue_redraw()

func deselect_all():
	var iter = range(slots.size())
	iter.reverse()
	for x in iter:
		if Slotflags.Selected & slot_flags[x]:
			deselect(x)
		
func on_advance_beat(_beat):
	queue_redraw()

func _ready():
	modulate.a = 0.3
	SignalBus.advance_beat.connect(on_advance_beat)
	SignalBus.pause_rythm.connect(on_pause)
	for x in range(3):
		slot_insert(0,0,0)
	z_index=-1
