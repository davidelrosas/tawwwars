extends Action

func action(target, caster):
	print("hallo")
	var projectile = preload("res://Towars/prefabs/projectile.tscn").instantiate()
	projectile.health_effect.power = 20
	projectile.position = caster.position + Vector2(100,100)
	caster.add_child(projectile)

func _process(delta):
	pass
