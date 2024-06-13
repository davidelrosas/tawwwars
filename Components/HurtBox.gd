class_name HurtBox

extends AreaComponent

var owner_entity : BaseEntity

func _ready():
	self.area_entered.connect(_on_area_entered)

func _on_area_entered(hitbox : HitBox):
	if hitbox == null:
		return
	
	if owner_entity.has_method("effect"):
		owner_entity.effect(hitbox.effects_list)
		hitbox.hitbox_hit.emit(owner_entity)

func set_layer(team_id, mode_id = mode.ENEMIESONLY, layer_1 = 0, layer_2 = 0, mask_1 = 2, mask_2 = 4):
	super.set_layer(team_id, mode_id, layer_1, layer_2, mask_1, mask_2)
	monitorable = false
