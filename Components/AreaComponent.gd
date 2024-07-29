class_name AreaComponent

extends Area2D

enum mode {ENEMIESONLY, ALLIESONLY, ALLENTITIES}

var mode_id : mode

func set_layer( team_id : BaseEntity.team, mode_id : mode, layer_1 : int, layer_2 : int, mask_1 : int, mask_2 : int ):
	self.mode_id = mode_id
	match mode_id:
		mode.ENEMIESONLY:
			if team_id == BaseEntity.team.PLAYER:
				collision_layer = layer_1
				collision_mask = mask_1
			else: 
				collision_layer = layer_2
				collision_mask = mask_2
		mode.ALLIESONLY:
			if team_id == BaseEntity.team.PLAYER:
				collision_layer = layer_2
				collision_mask = mask_2
			else: 
				collision_layer = layer_1
				collision_mask = mask_2
		mode.ALLENTITIES:
			collision_layer = layer_1 + layer_2
			collision_mask = mask_1 + mask_2
