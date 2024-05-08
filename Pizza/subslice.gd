extends Node2D
const PizzaSlice = preload("res://Pizza/slice.gd")
<<<<<<< HEAD
var pizza_properties : PizzaProperties
=======
>>>>>>> 2cf07bc0a87c746fe1911ea2e59f5adf6695a2e1

enum Slotflags {Selected = 1, Rest = 2, Towar = 4, Temporary = 8}
var flags : int
var baseColor : Color
<<<<<<< HEAD
var active_subbeat : bool = false
var towar : Towar = null

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
=======
var color : Color
var towar : Towar = null

var subbeat : int
var slice : PizzaSlice

func _init(flags_in : int, subbeat_in : int, slice_in : PizzaSlice):
	self.flags = flags_in
	subbeat = subbeat_in
	slice = slice_in
	
func _draw():
	var r_start = slice.get_radius(subbeat)
	var r_end = slice.get_radius(subbeat+1)
	var bottom_arc = slice.pizza_properties.get_arc(r_start,slice.beat)
	bottom_arc.reverse()   #polygon point order
	var top_arc = slice.pizza_properties.get_arc(r_end,slice.beat)
	
	draw_colored_polygon(bottom_arc+top_arc,color)
>>>>>>> 2cf07bc0a87c746fe1911ea2e59f5adf6695a2e1
	draw_polyline(top_arc,Color(0,0,0),6,true)
	
func reset_next()->void:
	await Timelord.advance_subbeat
<<<<<<< HEAD
	active_subbeat = false
	queue_redraw()
	
@warning_ignore("shadowed_variable")
func update_slot(slot : Vector2i):
	self.slot = slot
	bottom_arc = pizza_properties.get_arc(slot)
	bottom_arc.reverse()   #polygon point order
	top_arc = pizza_properties.get_arc(slot + Vector2i(0,1))
=======
	color = baseColor
>>>>>>> 2cf07bc0a87c746fe1911ea2e59f5adf6695a2e1
	queue_redraw()

func on_activation(actionbits:int,timing:float)->void:
	baseColor = Color(actionbits&1,actionbits&2,actionbits&4)
	queue_redraw()
	reset_next()
<<<<<<< HEAD
	
func on_subbeat()->void:
	active_subbeat = true
	queue_redraw()
	reset_next()

func color() -> Color:
	return baseColor.lerp(Color(flags & Slotflags.Selected,active_subbeat,0),0.5)
	
	
	
	
=======

func on_subbeat()->void:
	color = baseColor.inverted()
	queue_redraw()
	reset_next()
>>>>>>> 2cf07bc0a87c746fe1911ea2e59f5adf6695a2e1
