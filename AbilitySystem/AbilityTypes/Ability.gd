class_name Ability

extends Node2D

@export var animation : AnimationPlayer
@export var effects_list : Array[CombatEffect]
@export var max_targets : int
@export var cast_position_id : cast_position

#var next_part_trigger_condition

enum cast_position {ONTARGET, ONSELF}

func _ready():
	animation.play("anim_1")

func _process(delta):
	if animation.current_animation == "":
		queue_free()

func cast(target : Target, caster):
	pass

