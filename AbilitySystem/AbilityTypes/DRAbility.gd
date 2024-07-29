class_name DRAbility

extends AreaAbility

@export var det_area : DetectionArea
@export var det_mode: DetectionArea.mode

var in_area = {}

func set_area_component(caster : BaseEntity):
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
