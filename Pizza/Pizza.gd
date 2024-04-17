extends Node2D

@export var properties : PizzaProperties

var selector : Vector2i = Vector2i(-1,-1)
var selected : Vector2i = Vector2i(-1,-1)

var slices : Array[PizzaSlice] = []
	
func _draw():
	var col = Color(0,0,0)
	for x in range(Timelord.tempo.division+int(!properties.is_full_circle())):
		var dir = Vector2.from_angle(properties.get_beat_angle(x))
		draw_line(position+dir*properties.inner_radius, position+dir*properties.radius,col,5,true)
	draw_arc(position,properties.inner_radius,0,properties.angle,properties.get_arc_num_points(properties.inner_radius,properties.angle),Color(0,0,0),5)
	
func change_selection(selector_ : Vector2i = selector):
	slices[selected.x].deselect(selected.y)
	selector = selector_
	selector.x = (selector.x % Timelord.tempo.division) if properties.is_full_circle() else (clampi(selector.x,0,Timelord.tempo.division-1))
	selector.y = clampi(selector.y,0, slices[selector.x].slots.size()*2)
	selected= Vector2i(selector.x,slices[selector.x].select(selector.y))
			
func select_slice_from_vector(vec : Vector2):
	var vector = vec-global_position
	selector.x = floor(inverse_lerp(0,properties.angle,vector.angle())*(Timelord.tempo.division) as float)
	selector.y = int(inverse_lerp(properties.inner_radius,properties.radius,vector.length())*slices[min(Timelord.tempo.division-1,selector.x)].slots.size()*2)
	change_selection()
			
func start_selecting():
	selector = Vector2(0,0)
	selected = Vector2(0,slices[selector.x].select(selector.y))
	
func on_subbeat():
	slices[Timelord.back_beat()].subslices[Timelord.subbeat].on_subbeat()
	
func on_subbeat_hit(actionbits,timing):
	if actionbits:
		slices[Timelord.back_beat()].subslices[Timelord.subbeat].on_activation(actionbits,timing)
	
func _ready():
	Timelord.beat_change.connect(initialise)
	Timelord.advance_subbeat.connect(on_subbeat)
	InputManager.subbeat_hit.connect(on_subbeat_hit)
		
func initialise():
	show()
	slices = []
	for x in range(Timelord.tempo.division):
		slices.push_back(PizzaSlice.new(x,properties))
		add_child(slices[x])
	queue_redraw()
