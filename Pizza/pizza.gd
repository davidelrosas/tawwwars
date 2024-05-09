extends Node2D

@export var pizza_properties : PizzaProperties

const PizzaSlice = preload("res://Pizza/slice.gd")

var selected : Vector2i = Vector2i.ZERO

var slices : Array[PizzaSlice] = []

func get_subslice_from_vector (mouse_vector : Vector2)-> Vector2i:
	var relative = (mouse_vector-global_position).rotated(-global_rotation)
	var x = min(slices.size()-1,floor(slices.size() as float*fposmod(relative.angle(),TAU)/pizza_properties.angle))
	var y = clampi(0,slices[x].subslices.size()*2,inverse_lerp(pizza_properties.inner_radius,pizza_properties.radius,relative.length())*slices[x].subslices.size()*2)
	return Vector2i(x,y)

func _draw():
	var col = Color(0,0,0)
	for x in range(pizza_properties.division+int(!pizza_properties.is_full_circle())):
		var dir = Vector2.from_angle(pizza_properties.get_beat_angle(x))
		draw_line(position+dir*pizza_properties.inner_radius, position+dir*
			max(pizza_properties.get_max_radius_x(x-1),	pizza_properties.get_max_radius_x(x)),
			col,5,true)
	draw_arc(position,pizza_properties.inner_radius,0,pizza_properties.angle,pizza_properties.get_arc_num_points(pizza_properties.inner_radius,pizza_properties.angle),Color(0,0,0),5)
	

func highlight(selector : Vector2i):
	slices[selected.x].deselect(selected.y)
	selector = pizza_properties.selection_clampi(selector)
	selected= Vector2i(selector.x,slices[selector.x].select(selector.y))
	queue_redraw()
	
func on_subbeat():
	slices[Timelord.beat].subslices[Timelord.subbeat].on_subbeat()
	
func on_subbeat_hit(actionbits,timing):
	if actionbits:
		slices[Timelord.beat].subslices[Timelord.subbeat].on_activation(actionbits,timing)
	
func _ready():
	Timelord.beat_change.connect(initialise)
	Timelord.advance_subbeat.connect(on_subbeat)
	InputManager.subbeat_hit.connect(on_subbeat_hit)
	InputManager.changed_pizza_highlight.connect(highlight)
	if (!pizza_properties): print("Pizza properties not set!!!")
	initialise(pizza_properties)
		
func initialise(properties : PizzaProperties):
	pizza_properties = properties
	slices = []
	for x in range(pizza_properties.division):
		slices.push_back(PizzaSlice.new(x,pizza_properties))
		add_child(slices[x])
	queue_redraw()
	Timelord.set_pp(properties)
	Player.pizza_properties = properties
