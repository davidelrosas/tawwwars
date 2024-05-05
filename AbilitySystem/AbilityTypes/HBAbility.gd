class_name HBAbility

extends Ability

@export var hitbox : HitBox

func cast(target : Target, caster):
	caster.add_child(self)
	pass
