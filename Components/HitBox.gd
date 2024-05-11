class_name HitBox

extends Area2D

var effects_list : Array[CombatEffect]
# Hitbox having an enabled/disabled property or function would be usefull probably
#maybe give it to hurtbox too later

func _init():
	collision_layer = 2
	collision_mask = 0
	monitoring = false

func set_layer(team_id : BaseEntity.team):
	match team_id:
		BaseEntity.team.PLAYER:
			collision_layer = 4
			collision_mask = 0
		BaseEntity.team.ENEMY:
			collision_layer = 2
			collision_mask = 0
