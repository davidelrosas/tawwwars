class_name Ability

extends Node2D

@export var animation : AnimationPlayer
@export var effects_list : Array[CombatEffect]
@export var duration : float

#make class
@export var targeting : Array[Target.target_type]
@export var target_ammounts : PackedInt32Array
#@export var target_team : Array[BaseEntity.team]
# I should add here to choose from which team!!!!!! how can we make this a sort of exportable thing?

#var next_part_trigger_condition
var ability_next : Ability

var owner_entity : BaseEntity

func _ready():
	playanimation()

func cast(target_data : Target = owner_entity.target_data, caster : BaseEntity = owner_entity):
	#if target_data.targets_ready():
		#execute(target_data)
	#else:
	target_data.find(targeting, target_ammounts)
	if target_data.current_targets != []:  
		execute(target_data, caster)
	else:
		print("no targets in sight")
	#when does it get add as a child of the caster?

func execute(_target_data : Target, caster : BaseEntity):
	initialize_effects(caster)
	pass

func playanimation():
	if animation != null:
		animation.play("run")

func _process(_delta):
	if animation != null && animation.current_animation == "":
		queue_free()

#This should also probably add the caster Ability damage modifiers!!
# The ability should decide how its scaling will be -> so maybe export a variable for that
func initialize_effects(caster):
	for i in effects_list:
		#inside this function!!!
		i.initialize_effect(caster)

func set_timer(duration : float):
	var timer = Timer.new()
	timer.wait_time = duration 
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _on_timer_timeout():
	queue_free()
