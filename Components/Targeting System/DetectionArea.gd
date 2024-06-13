class_name DetectionArea

extends AreaComponent

signal entity_entered_range(entity : BaseEntity)
signal entity_exited_range(entity : BaseEntity)

var owner_entity : BaseEntity
var radius : float

#You are Gonna detect the Hurtbox
func _entered_range(entity : BaseEntity):
	entity_entered_range.emit(entity)
	

func _exited_range(entity : BaseEntity):
	entity_exited_range.emit(entity)


#i have idea the layers are gonna be passed with the function, and the function 
#body will be the same for all three Hurtbix Hutbix and Detection area
@warning_ignore("shadowed_variable")
func set_layer(team_id, mode_id, layer_1 = 0, layer_2 = 0, mask_1 = 16, mask_2 = 8):
	super.set_layer(team_id, mode_id, layer_1, layer_2, mask_1, mask_2)
	collision_layer = 0
	
	body_entered.connect(_entered_range)
	body_exited.connect(_exited_range)
	#SignalBus.entity_entered_scene.connect(_check_overlap)

func set_range(detection_range : float):
	radius = detection_range
	get_node("CollisionShape2D").shape.radius = radius
	
