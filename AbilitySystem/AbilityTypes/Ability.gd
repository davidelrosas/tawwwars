class_name Ability

extends Node2D

@export var animation : AnimationPlayer
@export var effects_list : Array[CombatEffect]
@export var max_targets : int

#var next_part_trigger_condition
var abilitytree : Ability

func _ready():
	playanimation()


func _process(delta):
	if animation.current_animation == "":
		queue_free()

func cast(target : Target, caster):
	pass

func playanimation():
	if animation != null:
		animation.play("run")
		if animation.current_animation == "run":
			print("hey")
