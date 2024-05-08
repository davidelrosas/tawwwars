class_name Ability

extends Node2D

@export var animation : AnimationPlayer
@export var effects_list : Array[CombatEffect]
@export var max_targets : int
@export var targeting : Target.target_type

#var next_part_trigger_condition
var abilitytree : Ability

func _ready():
	playanimation()

func cast(target : Target, caster):
	pass

func playanimation():
	if animation != null:
		animation.play("run")

func _process(delta):
	if animation.current_animation == "":
		queue_free()

func initialize_combat_effects(effects_list : Array[CombatEffect], caster):
	for i in effects_list:
		i.caster = caster
