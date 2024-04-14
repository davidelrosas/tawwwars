extends Action

func action(target : Target, caster : BaseEntity):
	if target.closest:
		var projectile = preload("res://Components/projectile.tscn").instantiate()
		var hitbox = projectile.get_node("HitBox")
		hitbox.set_layer(caster.team)
	
		hitbox.health_effect.power = 10 + caster.stats.ability_modifier
		projectile.target = target.closest
		projectile.position = caster.position
		projectile.speed = 200
		var dir = Vector2(randf_range(-1,1),randf_range(-1,1))
		projectile.direction = dir.normalized()
	
		caster.add_child(projectile)
