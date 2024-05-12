class_name HurtBox

extends Area2D

var owner_entity : BaseEntity

func _ready():
	self.area_entered.connect(_on_area_entered)

func _on_area_entered(hitbox : HitBox):
	if hitbox == null:
		return
	
	if owner_entity.has_method("effect"):
		owner_entity.effect(hitbox.effects_list)

func _init():
	collision_layer = 0
	collision_mask = 2
	monitorable = false

func set_layer(team_id : BaseEntity.team):
	match team_id:
		BaseEntity.team.PLAYER:
			collision_layer = 0
			collision_mask = 2
		BaseEntity.team.ENEMY:
			collision_layer = 0
			collision_mask = 4


