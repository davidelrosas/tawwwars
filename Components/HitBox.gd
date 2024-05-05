class_name HitBox

extends Area2D

var effects_list : Array[CombatEffect]

func _init():
	collision_layer = 2
	collision_mask = 0
	monitoring = false

func set_layer(team):
	match team:
		BaseEntity.team_id.PLAYER:
			collision_layer = 4
			collision_mask = 0
		BaseEntity.team_id.ENEMY:
			collision_layer = 2
			collision_mask = 0
			pass
