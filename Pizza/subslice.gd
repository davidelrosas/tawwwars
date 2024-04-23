extends Node2D
const PizzaSlice = preload("res://Pizza/slice.gd")

enum Slotflags {Selected = 1, Rest = 2, Towar = 4, Temporary = 8}
var flags : int
var baseColor : Color
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
	draw_polyline(top_arc,Color(0,0,0),6,true)
	
func reset_next()->void:
	await Timelord.advance_subbeat
	color = baseColor
	queue_redraw()

func on_activation(actionbits:int,timing:float)->void:
	baseColor = Color(actionbits&1,actionbits&2,actionbits&4)
	queue_redraw()
	reset_next()

func on_subbeat()->void:
	color = baseColor.inverted()
	queue_redraw()
	reset_next()
