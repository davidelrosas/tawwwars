extends Action

func action(target : Target, caster : BaseEntity):
	if target.current != null:
			shoot(target, caster)
	else:
		target.current = target.find_closest(caster)
		if target.current != null:
			shoot(target, caster)

func shoot(target : Target, caster : BaseEntity):
	var projectile = preload("res://Work_in_progress/projectile.tscn").instantiate()
	var hitbox = projectile.get_node("HitBox")
	hitbox.set_layer(caster.team)
	
	hitbox.health_effect.power = 10 + caster.stats.ability_modifier
	projectile.target = target.current
	projectile.position = caster.position
	projectile.speed = 200
	var dir = Vector2(randf_range(-1,1),randf_range(-1,1))
	projectile.direction = dir.normalized()
	
	caster.add_child(projectile)
