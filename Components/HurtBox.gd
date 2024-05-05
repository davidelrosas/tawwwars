class_name HurtBox

extends Area2D

var owner_entity_ref : BaseEntity

func _ready():
	self.area_entered.connect(_on_area_entered)

func _on_area_entered(hitbox : HitBox):
	if hitbox == null:
		return
	
	if owner_entity_ref.has_method("effect"):
		owner_entity_ref.effect(hitbox.effects_list)

func _init():
	collision_layer = 0
	collision_mask = 2
	monitorable = false

func set_layer(team):
	match team:
		BaseEntity.team_id.PLAYER:
			collision_layer = 0
			collision_mask = 2
		BaseEntity.team_id.ENEMY:
			collision_layer = 0
			collision_mask = 4
			pass

