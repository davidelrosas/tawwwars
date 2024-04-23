extends Node
class_name Metronome

@export var tempo : Tempo

func _ready():
	initiliase_timelord()
	#InputManager.pause_play.connect(initiliase_timelord())
	
func initiliase_timelord():
	Timelord.sync(tempo)
	queue_free()
