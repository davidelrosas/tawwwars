class_name DRAbility

extends Ability

@export var det_area : DetectionArea
@export var det_mode: DetectionArea.mode
@export var movement_engine : MovementEngine
@export var cast_position_id : cast_position

@export_flags("TIMED:1") var mode = 0
@export var speed : float

var in_area = {}

enum cast_position {ONTARGET, ONSELF}

func cast(target_data = owner_entity.target_data, caster = owner_entity):
	super.cast(target_data, caster)

func execute(target_data, caster):
	
	var pack_ability = PackedScene.new()
	pack_ability.pack(self)
	for i in target_data.current_targets:
		var duplicate = pack_ability.instantiate()
		
		duplicate.initialize_effects(caster)
		duplicate.set_det_area(caster)
		if mode & 1:
			duplicate.set_timer(duration)
		duplicate.set_as_top_level(true)
		
		match cast_position_id:
			cast_position.ONTARGET:
				duplicate.global_position = i.global_position
			cast_position.ONSELF:
				duplicate.global_position = caster.global_position
		#Abilities will move in the level above casters, sometimes tho be attached to EntitiesItself
		if movement_engine != null:
			duplicate.movement_engine.set_properties(speed,i.global_position - duplicate.global_position, i, duplicate)
		caster.get_parent().add_child(duplicate)
		# maybe add a timed multicast option as wellduplicate

func set_det_area(caster : BaseEntity):
	det_area.entity_entered_range.connect(_store_entity)
	det_area.entity_exited_range.connect(_delete_entity)
	
	det_area.set_layer(caster.team_id, det_mode)
	#you should set the variable range in det_area

func _store_entity(entity : BaseEntity):
	var effect_list_dup = []
	for i in effects_list:
		var effect = i.duplicate()
		effect.apply(entity)
		effect_list_dup.append(effect)
		
	in_area[entity] = effect_list_dup

func _delete_entity(entity : BaseEntity):
	if in_area.has(entity):
		for i in in_area[entity]:
			i.end_effect()
		in_area.erase(entity)
