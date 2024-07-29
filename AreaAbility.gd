class_name AreaAbility

extends Ability

@export var movement_engine : MovementEngine
@export var cast_position_id : cast_position

@export_flags("TIMED:1","IMPACT_DETECTION:2") var mode = 0
@export var max_impacts : int
@export var speed : float

enum cast_position {ONTARGET, ONSELF}

func cast(target_data = owner_entity.target_data, caster = owner_entity):
	super.cast(target_data, caster)
