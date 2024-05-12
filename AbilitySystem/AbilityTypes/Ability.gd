class_name Ability

extends Node2D

@export var animation : AnimationPlayer
@export var effects_list : Array[CombatEffect]

#make class
@export var targeting : Array[Target.target_type]
@export var target_ammounts : PackedInt32Array

#var next_part_trigger_condition
var ability_next : Ability

func _ready():
	playanimation()

func cast(target_data : Target, caster : BaseEntity):
	#if target_data.targets_ready():
		#execute(target_data)
	#else:
	target_data.find(targeting, target_ammounts)
	print(target_data.in_range)
	if target_data.current_targets != []:  
		print(target_data.current_targets)
		execute(target_data, caster)
	print("no targets in sight")
	#when does it get add as a child of the caster?

func execute(target_data : Target, caster : BaseEntity):
	pass

func playanimation():
	if animation != null:
		animation.play("run")

func _process(delta):
	if animation != null && animation.current_animation == "":
		queue_free()

func initialize_effects(caster):
	for i in effects_list:
		i.initialize_effect(caster)
