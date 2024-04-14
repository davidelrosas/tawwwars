extends Node2D

@export var properties : pizza_properties

const pizza_slice_script = preload("res://Pizza/slice.gd")
const pizza_properties_script = preload("res://Pizza/pizza_properties.gd")

var beat : int = 0
var elapsed : float = 0
var selector : Vector2i = Vector2i(-1,-1)
var selected : Vector2i = Vector2i(-1,-1)

var paused : bool = true
	
var slices : Array = []

func advance_beat(beet:int):
	beat = beet
	queue_redraw()

func _draw():
	var col = Color(0,0,0)
	for x in range(properties.division+int(!properties.is_full_circle())):
		var dir = Vector2(0,-1).rotated(properties.div_angle()*x)
		draw_line(position+dir*properties.inner_radius, position+dir*properties.radius,col,5,true)
	draw_arc(position,properties.inner_radius,-PI/2,properties.angle-PI/2,properties.get_arc_num_points(properties.inner_radius,properties.angle),Color(0,0,0),5)

func get_rps():
	return slices[beat].get_rps() * int(!paused)
	
func pause():
	paused = true
	SignalBus.pause_rythm.emit()

func get_beat_angle(beet : int = beat):
	return pizza_slice_script.get_start_angle(beet)
	
func change_selection(selector_ : Vector2i = selector):
	slices[selected.x].deselect(selected.y)
	selector = selector_
	selector.x = (selector.x % properties.division) if properties.is_full_circle() else (clampi(selector.x,0,properties.division-1))
	selector.y = clampi(selector.y,0, slices[selector.x].slots.size()*2)
	selected= Vector2i(selector.x,slices[selector.x].select(selector.y))
	
var actionEventDick : Dictionary = {
	"Up" : func() : selector.y +=1,
	"Down" : func() :selector.y -= 1,
	"Left" : func():selector.x -= 1,
	"Right" : func():selector.x += 1
}

func _input(event): #rudimentary selection, will be moved
	if (paused):
		for x in actionEventDick.keys():
			if event.is_action_pressed(x):
				actionEventDick[x].call()
				change_selection()
		if event.is_action_pressed("Pause"):
			from_the_top()
		elif event is InputEventMouseMotion :
			var vector = (event as InputEventMouseMotion).position-global_position
			selector.x = floor(inverse_lerp(0,properties.angle,fmod(-vector.angle_to(Vector2(0,-1))+TAU,TAU))*(properties.division) as float)
			selector.y = int(inverse_lerp(properties.inner_radius,properties.radius,vector.length())*slices[min(properties.division-1,selector.x)].slots.size()*2)
			change_selection()
	elif (event.is_action_pressed("Pause")):
		start_selecting()

func start_selecting():
	pause()
	selector = Vector2(0,0)
	selected = Vector2(0,slices[selector.x].select(selector.y))

func _ready():
	for x in range(properties.division):
		slices.push_back(pizza_slice_script.new(x,properties))
		add_child(slices[x])
	SignalBus.advance_beat.connect(advance_beat)
	queue_redraw()
	
func from_the_top():
	for x in slices:
		x.deselect_all()
	paused = false
	elapsed = 0
	beat = 0
	SignalBus.advance_beat.emit(0)

func _process(delta):
	if (!paused):
		elapsed = slices[beat].elapse(elapsed+delta)
