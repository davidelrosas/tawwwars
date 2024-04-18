extends Node2D
class_name PizzaSlice

const Subslice = preload("res://Pizza/subslice.gd")

var subslices : Array[Subslice]
var beat : int = 0

var pizza_properties : PizzaProperties
	
func on_subdiv():
	queue_redraw()
	
func angle():
	return pizza_properties.angle / Timelord.tempo.division
	
func is_active()->bool:
	return self.beat == Timelord.back_beat()

func get_arc(radius) -> PackedVector2Array:
	var num_points : int = pizza_properties.get_arc_num_points(radius,angle())
	var points : PackedVector2Array = PackedVector2Array()
	for x in range(num_points+1):
		points.push_back(Vector2(radius,0).rotated(angle()*(float(x)/float(num_points)+beat)))
	return points

func _init(beat : int, pizza_props : PizzaProperties):
	self.beat = beat
	pizza_properties = pizza_props
	
func get_radius(subbeat : float):
	return lerp(100, pizza_properties.radius, subbeat / subslices.size())

func update_subdivisions():
	Timelord.subdivisions[beat] = subslices.size()
	for x in range(subslices.size()): subslices[x].subbeat = x

func slot_insert(index, ss : Subslice):
	subslices.insert(index,ss)
	add_child(ss)
	update_subdivisions()
	
func slot_delete(index):
	subslices[index].queue_free()
	subslices.remove_at(index)
	update_subdivisions()

func select(selector : int) -> int:
	var selection = clamp(selector,0,subslices.size() * 2)
	if (!(1&selection)):
		slot_insert(selection/2,Subslice.new(Subslice.Slotflags.Selected | Subslice.Slotflags.Temporary,selection/2,self))
	else:
		subslices[selection/2].flags |= Subslice.Slotflags.Selected
	queue_redraw()
	return selection / 2

func deselect(index : int):
	if Subslice.Slotflags.Temporary & subslices[index].flags:
		slot_delete(index)
	else:
		subslices[index].flags ^= Subslice.Slotflags.Selected
	queue_redraw()

func deselect_all():
	var iter = range(subslices.size())
	iter.reverse()
	for x in iter:
		if Subslice.Slotflags.Selected & subslices[x].flags:
			deselect(x)

func _ready():
	modulate.a = 0.3
	Timelord.advance_subbeat.connect(on_subdiv)
	var how_many = 4
	for x in range(how_many):
		slot_insert(0,Subslice.new(2,x,self))
	z_index=-1
