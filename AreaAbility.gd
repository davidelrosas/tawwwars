class_name AreaAbility

extends Ability

@export var movement_engine : MovementEngine
@export var cast_position_id : cast_position

# para el explosive shot hacer que trigeree la siguiente habilidad cuando llegue a un vector
@export_flags("TIMED:1","IMPACT_DETECTION:2") var mode = 0
@export var max_impacts : int
@export var speed : float

enum cast_position {ONTARGET, ONSELF, ABSOLUTE}
#var vector_offset

func cast(target_data = owner_entity.target_data, caster = owner_entity):
	super.cast(target_data, caster)


func execute(target_data, caster):
	
	print(owner_entity)
	var pack_ability = PackedScene.new()
	pack_ability.pack(self)
	for i in target_data.current_targets:
		var duplicate = pack_ability.instantiate()
		
		#owner_entity is not being copied because its set in code!! what to do about it?
		duplicate.owner_entity = self.owner_entity
		
		duplicate.initialize_effects(caster)
		duplicate.set_area_component(caster)
		if mode & 1:
			duplicate.set_timer(duration)
		if mode & 2:
			duplicate.set_impact_detection(caster)
		duplicate.set_as_top_level(true)
		
		match cast_position_id:
			cast_position.ONTARGET:
				duplicate.global_position = i.global_position #what if we want offset
			cast_position.ONSELF:
				duplicate.global_position = caster.global_position
			cast_position.ABSOLUTE:
				duplicate.global_position = abs_cast_position
		#Abilities will move in the level above casters, sometimes tho be attached to EntitiesItself
		if movement_engine != null:
			duplicate.movement_engine.set_properties(speed,i.global_position - duplicate.global_position, i, duplicate)
		#Probably make the ability child of a more specific layer
		caster.get_parent().add_child(duplicate)
		# maybe add a timed multicast option as wellduplicate


func set_area_component(caster : BaseEntity):
	pass

func set_impact_detection(caster : BaseEntity):
	pass
