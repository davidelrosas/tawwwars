extends Node2D

@export var duration : float
@export var hitbox : HitBox
@export var effects_list : Array[CombatEffect]
@export var animation : AnimationPlayer

var target : BaseEntity
var caster : BaseEntity

var owner_entity : BaseEntity


func cast(target_data = owner_entity.target_data, caster = owner_entity):
	target = target_data.find_closest(caster)
	if target != null:
		execute(caster)
	else:
		print("no target in sight")

func execute(caster):
	set_timer(duration)
	hitbox.effects_list = effects_list
	hitbox.set_layer(caster.team_id)
	global_position = target.global_position
	caster.get_parent().add_child(self)

func set_timer(duration : float):
	var timer = Timer.new()
	timer.wait_time = duration 
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _on_timer_timeout():
	queue_free()
