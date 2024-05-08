extends Node2D
const Subslice = preload("res://Pizza/subslice.gd")

var subslices : Array[Subslice]
var beat : int = 0

var pizza_properties : PizzaProperties
	
func on_subdiv():
	queue_redraw()
	
func angle():
	return pizza_properties.angle / pizza_properties.division
	
func is_active()->bool:
	return self.beat == Timelord.back_beat()

@warning_ignore("shadowed_variable")
func _init(beat : int, pizza_properties : PizzaProperties):
	self.beat = beat
	self.pizza_properties = pizza_properties

func update_subdivisions():
	pizza_properties.subdivisions[beat] = subslices.size()
	for x in range(subslices.size()): subslices[x].update_slot(Vector2i(beat,x))

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
		slot_insert(selection/2,Subslice.new(Subslice.Slotflags.Selected | Subslice.Slotflags.Temporary,Vector2i(beat,selection/2),pizza_properties))
	else:
		subslices[selection/2].flags |= Subslice.Slotflags.Selected
	update_subdivisions()
	return selection / 2

func deselect(index : int):
	if Subslice.Slotflags.Temporary & subslices[index].flags:
		slot_delete(index)
	else:
		subslices[index].flags &= ~Subslice.Slotflags.Selected
	update_subdivisions()
	
func get_radius():
	return pizza_properties.get_radius(Vector2i(beat,pizza_properties.subdivisions[beat]))

func deselect_all():
	var iter = range(subslices.size())
	iter.reverse()
	for x in iter:
		if Subslice.Slotflags.Selected & subslices[x].flags:
			deselect(x)

func _ready():
	modulate.a = 0.3
	Timelord.advance_subbeat.connect(on_subdiv)
	var how_many = beat+1
	for x in range(how_many):
		slot_insert(0,Subslice.new(2,Vector2(beat,x),pizza_properties))
	z_index=-1
