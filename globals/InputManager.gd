extends Node

#rythm input
class Combo:
	var events : Array[InputEventAction]
	
var rythmActions : PackedStringArray = ["ActionSet1","ActionSet2","ActionSet3","ActionSet4"] 

const simultaneous_press : float = 0.03
var time_tolerance : float = 0.2

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

#utility signals
signal pause_play()

signal build_mode_activation()
signal action_mode_activation()

signal change_pizza_highlight(selector : Vector2i)
signal build_on_selection()
#signal build_on_pizza(slot : Vector2i)

#signal select_subslice(selector : Vector2ie)

#utility input


#pizza selection

var pizza_selector : Vector2i = Vector2i(0,0)

#mutually exclusive input profiles
enum InputMode {
	Build = 0,
	Action = 1,
	Shop = 2
}

var input_mode : InputMode = InputMode.Build

class InputSet:
	var actions : Dictionary
	func process() -> void:
		for action in actions.keys():
			if(Input.is_action_just_pressed(action)):
				actions[action].call()
	func _init(actions : Dictionary):
		self.actions = actions


var utilityActions : InputSet = InputSet.new( {
	"Pause" : func():
		pause_play.emit()
		input_mode = !(input_mode) as int as InputMode,
	"BuildMode": func():
		input_mode = InputMode.Build
		build_mode_activation.emit(),
	"ActionMode": func(): 
		input_mode = InputMode.Action
		action_mode_activation.emit()
})

var buildActions : InputSet = InputSet.new({
	"Select" : func():
		pass,
	"Use" : func():
		build_on_selection.emit()
		input_mode = InputMode.Shop
})

func _process(_delta):
	match (input_mode):
		InputMode.Action:
			if !Timelord.is_paused():
				for action in range(rythmActions.size()):
					if Input.is_action_just_pressed(rythmActions[action]):
						process_action(action)
			
		InputMode.Build:
			var selector_delta = Vector2i(
				int(Input.is_action_just_pressed("Right"))-int(Input.is_action_just_pressed("Left")),
				int(Input.is_action_just_pressed("Up"))-int(Input.is_action_just_pressed("Down"))
			)
			if selector_delta:
				pizza_selector= Player.pizza_properties.selection_clampi(pizza_selector + selector_delta)
				print (pizza_selector.y, Timelord.pizza_properties.subdivisions[pizza_selector.x])
				change_pizza_highlight.emit(pizza_selector)
			buildActions.process()
		InputMode.Shop:
			if Input.is_action_just_pressed("Use"):
				SignalBus.open_shop.emit()
				input_mode = InputMode.Build if Timelord.is_paused() else InputMode.Action
				
	utilityActions.process()
			

func _ready():
	Timelord.advance_subbeat.connect(on_subbeat)
	Timelord.beat_change.connect(on_beat_change)
	rest_timer.one_shot = true
	rest_timer.timeout.connect(rest_timer_timeout)
	add_child(rest_timer)
