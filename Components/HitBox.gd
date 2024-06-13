class_name HitBox

extends AreaComponent

signal hitbox_hit(entity : BaseEntity)

var effects_list : Array[CombatEffect]
# Hitbox having an enabled/disabled property or function would be usefull probably
#maybe give it to hurtbox too later

func set_layer(team_id, mode_id, layer_1 = 4, layer_2 = 2, mask_1 = 0, mask_2 = 0):
	super.set_layer(team_id, mode_id, layer_1, layer_2, mask_1, mask_2)
	monitoring = false
