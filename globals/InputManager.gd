extends Node

#rythm input
class Combo:
	var events : Array[InputEventAction]
	
var rythmActions : PackedStringArray = ["ActionSet1","ActionSet2","ActionSet3","ActionSet4"] 

const simultaneous_press : float = 0.03
var time_tolerance : float = 0.3

func on_beat_change():
	time_tolerance = min (time_tolerance,Timelord.interval()/8)

signal subbeat_hit(actionBits : int, timing : float)

signal miss()

var __action_bits : int = 0
var __action_timing : float = 0

var rest_timer : Timer = Timer.new()

func rest_timer_timeout() -> void:
	subbeat_hit.emit(__action_bits,__action_timing)
	__action_bits = 0
	
func on_subbeat():
	rest_timer.start(time_tolerance)

func process_action(action_index : int):
	var timetobeat = Timelord.to_closest_subbeat()
	if time_tolerance<abs(timetobeat) || (__action_bits&& abs(__action_timing - timetobeat)>simultaneous_press):
		miss.emit()
		return
	elif !__action_bits:
		__action_timing = timetobeat
		print(__action_timing)
	__action_bits |= 1<<action_index

#other input

signal pause_play()

func _process(_delta):
	if !Timelord.is_paused():
		for action in range(rythmActions.size()):
			if Input.is_action_just_pressed(rythmActions[action]):
				process_action(action)
	if (Input.is_action_just_pressed("Pause")):
		pause_play.emit()
			

func _ready():
	Timelord.advance_subbeat.connect(on_subbeat)
	Timelord.beat_change.connect(on_beat_change)
	rest_timer.one_shot = true
	rest_timer.timeout.connect(rest_timer_timeout)
	add_child(rest_timer)
