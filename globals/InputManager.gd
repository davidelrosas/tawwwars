extends Node

#rythm input
class Combo:
	var events : Array[InputEventAction]
	
var rythmActions : PackedStringArray = ["ActionSet1","ActionSet2","ActionSet3","ActionSet4"] 

const simultaneous_press : float = 0.03

signal subbeat_hit(actionBits : int)

signal miss()

var __action_bits : int = 0
#var __action_timing : float = 0

var simul_timer : Timer = Timer.new()
	
func simul_timer_timeout():
	subbeat_hit.emit(__action_bits)
	__action_bits = 0

func process_action(action_index : int):
	if (simul_timer.is_stopped() && !__action_bits):
		simul_timer.start(simultaneous_press)
	__action_bits |= 1 << action_index

#utility signals
signal pause_play()

signal build_mode_activation()
signal action_mode_activation()

signal change_pizza_highlight(selector : Vector2i)
signal build_on_selection()

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
		
class InputDelegator:
	var actions : PackedStringArray
	signal input(action : String)
	func process() -> void:
		for a in actions:
			if (Input.is_action_just_pressed(a)):
				input.emit(a)
	@warning_ignore("shadowed_variable")
	func _init(actions : PackedStringArray):
		self.actions = actions
		
class InputSet extends InputDelegator:
	var actionSet : Dictionary
	func on_input(action : String):
		actionSet[action].call()
	func _init(actionSet : Dictionary):
		self.actionSet = actionSet
		super(actionSet.keys())
		input.connect(on_input)

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
	"Use" : func():
		build_on_selection.emit()
		input_mode = InputMode.Shop
})

var shopActions : InputDelegator = InputDelegator.new([
	"Left", "Right", "Up", "Down"
])

func _input(event):
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
			if selector_delta && Player.pizza_properties:
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
	simul_timer.one_shot = true
	simul_timer.timeout.connect(simul_timer_timeout)
	add_child(simul_timer)
