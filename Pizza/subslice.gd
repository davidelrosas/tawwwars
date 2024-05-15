extends Node2D
const PizzaSlice = preload("res://Pizza/slice.gd")
var pizza_properties : PizzaProperties

enum Slotflags {Selected = 1, Rest = 2, Towar = 4, Temporary = 8}
var flags : int
var baseColor : Color
var active_subbeat : bool = false
var towar : Towar = null

var pos : Vector2

var slot : Vector2i

@warning_ignore("shadowed_variable")
func _init(flags : int, slot : Vector2i, pizza_properties : PizzaProperties):
	self.flags = flags
	self.slot = slot
	self.pizza_properties = pizza_properties
	
var top_arc : PackedVector2Array
var bottom_arc : PackedVector2Array
	
func _draw():
	draw_colored_polygon(bottom_arc+top_arc,color())
	draw_polyline(top_arc,Color(0,0,0),6,true)
	
func reset_next()->void:
	await Timelord.advance_subbeat
	active_subbeat = false
	queue_redraw()
	
func place_towar(towar : Towar)->void:
	self.towar = towar
	towar.position = pos
	add_child(towar)
	if (SignalBus.build_towar.is_connected(place_towar)):
		SignalBus.build_towar.disconnect(place_towar)
	flags &= ~(Slotflags.Temporary | Slotflags.Rest)
	
func clear_towar()->void:
	towar.queue_free()
	
@warning_ignore("shadowed_variable")
func update_slot(slot : Vector2i):
	self.slot = slot
	bottom_arc = pizza_properties.get_arc(slot)
	bottom_arc.reverse()   #polygon point order
	top_arc = pizza_properties.get_arc(slot + Vector2i(0,1))
	pos = pizza_properties.get_relative_slot_middle(slot)
	if towar:
		towar.position = pos
	queue_redraw()

func on_activation(actionbits:int)->void:
	baseColor = Color(actionbits&1,actionbits&2,actionbits&4)
	if (towar):
		towar.cast()
		
	queue_redraw()
	reset_next()
	
func on_subbeat()->void:
	active_subbeat = true
	queue_redraw()
	reset_next()

func color() -> Color:
	return baseColor.lerp(Color(flags & Slotflags.Selected,active_subbeat,0),0.5)
	
	
	
	
