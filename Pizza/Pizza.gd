extends Node2D

@export var pizza_properties : PizzaProperties

var selected : Vector2i = Vector2i(-1,-1)

var slices : Array[PizzaSlice] = []

func get_subslice_from_vector (mouse_vector : Vector2)-> Vector2i:
	var relative = (mouse_vector-global_position).rotated(-global_rotation)
	var x = min(slices.size()-1,floor(slices.size() as float*fposmod(relative.angle(),TAU)/pizza_properties.angle))
	var y = clampi(0,slices[x].subslices.size()*2,inverse_lerp(pizza_properties.inner_radius,pizza_properties.radius,relative.length())*slices[x].subslices.size()*2)
	return Vector2i(x,y)

func _draw():
	var col = Color(0,0,0)
	for x in range(Timelord.tempo.division+int(!pizza_properties.is_full_circle())):
		var dir = Vector2.from_angle(pizza_properties.get_beat_angle(x))
		draw_line(position+dir*pizza_properties.inner_radius, position+dir*pizza_properties.radius,col,5,true)
	draw_arc(position,pizza_properties.inner_radius,0,pizza_properties.angle,pizza_properties.get_arc_num_points(pizza_properties.inner_radius,pizza_properties.angle),Color(0,0,0),5)
	
func change_selection(selector : Vector2i):
	slices[selected.x].deselect(selected.y)
	selector.x = (selector.x % slices.size()) if pizza_properties.is_full_circle() else (clampi(selector.x,0,slices.size()-1))
	selector.y = clampi(selector.y,0, slices[selector.x].slots.size()*2)
	selected= Vector2i(selector.x,slices[selector.x].select(selector.y))
	
func on_subbeat():
	slices[back_beat()].subslices[Timelord.subbeat].on_subbeat()
	
func on_subbeat_hit(actionbits,timing):
	if actionbits:
		slices[back_beat()].subslices[Timelord.subbeat].on_activation(actionbits,timing)

func back_beat() -> int:
	return (int(pizza_properties.is_beat_reverse())*(Timelord.tempo.division-Timelord.beat-1))+(int(!pizza_properties.is_beat_reverse())*(Timelord.beat))
	
func _ready():
	Timelord.beat_change.connect(initialise)
	Timelord.advance_subbeat.connect(on_subbeat)
	InputManager.subbeat_hit.connect(on_subbeat_hit)
		
func initialise():
	show()
	slices = []
	for x in range(Timelord.tempo.division):
		slices.push_back(PizzaSlice.new(x,pizza_properties))
		add_child(slices[x])
	queue_redraw()
