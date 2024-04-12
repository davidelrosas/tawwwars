extends Node2D

@export_category("rythm")
@export var division : int = 4
@export var swing : float = 0.5
@export var bpm : int = 120

@export_category("shape")
@export var angle : float = TAU
@export var radius : int = 200

var full_circle : bool
var reverse : bool = false

var beat : int = 0
var elapsed : float = 0
var interval = 0

var paused : bool = true

func make_peegles():
	peegle_circles = []
	for x in range(16):
		peegle_circles.push_back(random_point_in_subdiv())

func advance_beat():
	if !(beat%division):
		reverse = !(reverse || full_circle)
		beat = 0
		SignalBus.advance_measure.emit()
	interval = 60 as float / bpm * get_swing_multiplier()
	SignalBus.advance_beat.emit(beat)
	
	
	make_peegles()
	queue_redraw()
	
var peegle_circles = []

func get_swing_multiplier():
	return (1&division) + int(!(1 & division)) * (2*((1-swing) if 1 & beat else swing))
	
func _draw():
	var col = Color(200,200,200)
	for x in range(division+1):
		draw_line(position, position+Vector2(0,-radius).rotated(get_beat_angle(x)),col,5,true)
	draw_arc(position,radius,-PI/2,-PI/2+angle,32,col,5,true)
	
	for x in peegle_circles:
		draw_circle(position+x,5,Color(255,0,1))
	
func get_beat_angle(beet : int = beat):
	var angela = angle*beet/division
	return (angle - angela) if reverse else angela

func random_point_in_subdiv():
	return Vector2(0,-radius).rotated(randf_range(get_beat_angle(beat),get_beat_angle(beat+1)))*randf()

func _ready():
	randomize()
	make_peegles()
	full_circle = angle >= 6.282
	
func from_the_top():
	paused = false
	elapsed = 0
	beat = 0
	reverse = true
	advance_beat()

func _process(delta):
	if (!paused):
		elapsed += delta
		if (elapsed >= interval):
			elapsed -= interval
			beat = beat+1
			advance_beat()
