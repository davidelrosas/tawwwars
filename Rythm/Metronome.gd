extends Node
class_name Metronome

@export var tempo : Tempo

func _ready():
	Timelord.initialise(tempo)
