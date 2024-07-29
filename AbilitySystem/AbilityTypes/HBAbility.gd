class_name HBAbility

extends AreaAbility

@export var hitbox : HitBox
@export var hitbox_mode : HitBox.mode

func set_area_component(caster : BaseEntity):
	hitbox.effects_list = self.effects_list
	hitbox.set_layer(caster.team_id, hitbox_mode)
	#set_hitbox behaviour so (mode)

func set_impact_detection(caster : BaseEntity):
	hitbox.hitbox_hit.connect(_on_impact_detection)

func _on_impact_detection(body : BaseEntity):
	if hitbox.collision_layer == body.hurtbox.collision_mask:
		max_impacts -= 1
		if max_impacts == 0:
			end_ability()
