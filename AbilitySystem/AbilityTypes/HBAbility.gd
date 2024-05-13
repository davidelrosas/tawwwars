class_name HBAbility

extends Ability

@export var cast_position_id : cast_position
@export var hitbox : HitBox
@export var impact_detector : Area2D
@export_flags("IMPACT_DETECTION", "TIMED") var mode

enum cast_position {ONTARGET, ONSELF}

func cast(target_data, caster):
	super.cast(target_data, caster)
	hitbox.effects_list = self.effects_list
	hitbox.set_layer(caster.team_id)

func shoot(target, caster):
	look_at(global_position + target.current.global_position)
	if cast_position_id == cast_position.ONTARGET:
		global_position = target.current.global_position
	else:
		global_position = caster.global_position
		
	set_as_top_level(true)
	caster.get_parent().add_child(self)

func execute(target_data, caster):
	super.execute(target_data, caster)
	if target_data.current_targets.size() == 1:
		return
	pass

func set_hitbox():
	pass

func set_impact_detection():
	pass
