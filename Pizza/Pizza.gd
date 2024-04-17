extends Node2D

@export var pizza_properties : PizzaProperties

var selector : Vector2i = Vector2i(-1,-1)
var selected : Vector2i = Vector2i(-1,-1)

var slices : Array[PizzaSlice] = []
	
func _draw():
	var col = Color(0,0,0)
	for x in range(Timelord.tempo.division+int(!pizza_properties.is_full_circle())):
		var dir = Vector2.from_angle(pizza_properties.get_beat_angle(x))
		draw_line(position+dir*pizza_properties.inner_radius, position+dir*pizza_properties.radius,col,5,true)
	draw_arc(position,pizza_properties.inner_radius,0,pizza_properties.angle,pizza_properties.get_arc_num_points(pizza_properties.inner_radius,pizza_properties.angle),Color(0,0,0),5)
	
func change_selection(selector_ : Vector2i = selector):
	slices[selected.x].deselect(selected.y)
	selector = selector_
	selector.x = (selector.x % Timelord.tempo.division) if pizza_properties.is_full_circle() else (clampi(selector.x,0,Timelord.tempo.division-1))
	selector.y = clampi(selector.y,0, slices[selector.x].slots.size()*2)
	selected= Vector2i(selector.x,slices[selector.x].select(selector.y))
			
func select_slice_from_vector(vec : Vector2):
	var vector = vec-global_position
	selector.x = floor(inverse_lerp(0,pizza_properties.angle,vector.angle())*(Timelord.tempo.division) as float)
	selector.y = int(inverse_lerp(pizza_properties.inner_radius,pizza_properties.radius,vector.length())*slices[min(Timelord.tempo.division-1,selector.x)].slots.size()*2)
	change_selection()
			
func start_selecting():
	selector = Vector2(0,0)
	selected = Vector2(0,slices[selector.x].select(selector.y))
	
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
