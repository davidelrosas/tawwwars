extends Node2D

@export var det_area : Area2D
@export var mode : detection_mode
var in_area : Array[BaseEntity]

enum detection_mode {ENEMIESONLY, ALLIESONLY, ALLENTITIES}

func _ready():
	pass
	
func cast(target_data : Target, caster : BaseEntity):
	set_properties(caster, mode)
	global_position = caster.global_position
	caster.get_parent().add_child(self)

func _on_entered_range(entity):
	in_area.append(entity)

func _on_exited_range(entity):
	if in_area.has(entity):
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
