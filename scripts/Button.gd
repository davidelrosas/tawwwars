extends Button

const ActionSet = preload ("res://scripts/ActionSetFinder.gd").ActionSet
@export var inputActionSet: ActionSet
var _actionSet

func _ready():
	toggle_mode = true
	_actionSet = ActionSetFinder.actionSetDict[inputActionSet]

func _process(_delta):
	if Input.is_action_just_released(_actionSet):
		_triggerButtonPressVisual()
		
func _triggerButtonPressVisual():
	set_pressed_no_signal(true)
	await get_tree().create_timer(0.2).timeout
	set_pressed_no_signal(false)
