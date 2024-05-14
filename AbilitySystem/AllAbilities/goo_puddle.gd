extends Node2D

@export var effects_list : Array[CombatEffect]
@export var det_area : Area2D
@export var mode : detection_mode
# when queue_freeing the node we have to make sure to deactivate all healtheffects it caused
@export var duration : float

var in_area = {}
enum detection_mode {ENEMIESONLY, ALLIESONLY, ALLENTITIES}

#for abilities for the layer they are seen say if they are cast on ground or cast on air!
func _ready():
	z_index = -1
	pass
	
func cast(target_data : Target, caster : BaseEntity):
	set_properties(caster, mode)
	global_position = caster.global_position
	set_timer(duration)
	caster.get_parent().add_child(self)

func _on_entered_range(entity):
	var effect_list_dup = []
	for i in effects_list:
		#probably later inside of takes functions depending on resistances and effects!!
		#if effect_not_active_or_greater(i) == true:
		var effect = i.duplicate()
		effect.apply(entity)
		effect_list_dup.append(effect)
		
	in_area[entity] = effect_list_dup

func _on_exited_range(entity):
	if in_area.has(entity):
		for i in in_area[entity]:
			i.end_effect()
		in_area.erase(entity)

@warning_ignore("shadowed_variable")
func set_properties(caster, mode : detection_mode = detection_mode.ENEMIESONLY):
	det_area.collision_layer = 0
	match mode:
		detection_mode.ENEMIESONLY:
			if caster.team_id == BaseEntity.team.PLAYER:
				det_area.collision_mask = 16
			else: 
				det_area.collision_mask = 8
		detection_mode.ALLIESONLY:
			if caster.team_id == BaseEntity.team.PLAYER:
				det_area.collision_mask = 8
			else: 
				det_area.collision_mask = 16
		detection_mode.ALLENTITIES:
			det_area.collision_mask = 0b11000
			
	det_area.body_entered.connect(_on_entered_range)
	det_area.body_exited.connect(_on_exited_range)

func set_timer(duration : float):
	var timer = Timer.new()
	timer.wait_time = duration 
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _on_timer_timeout():
	queue_free()
	
