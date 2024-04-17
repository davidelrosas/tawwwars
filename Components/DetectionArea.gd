class_name DetectionArea

extends Area2D

enum detection_mode {ENEMIESONLY, ALLIESONLY, ALLENTITIES}
var owner_entity : BaseEntity
var radius : float
var mode : detection_mode

func _ready():
	body_entered.connect(_entered_range)
	body_exited.connect(_exited_range)
	SignalBus.entity_entered_tree.connect(_check_overlap)

func _entered_range(appearence):
	if appearence.get_parent() != owner_entity:
		owner_entity.target_data.in_range.append(appearence.get_parent())
		print(owner_entity.metadata.displayname)
		print(owner_entity.target_data.in_range)

func _exited_range(appearence):
	if owner_entity.target_data.in_range.has(appearence.get_parent()):
		owner_entity.target_data.in_range.erase(appearence.get_parent())
		if owner_entity.target_data.current == appearence.get_parent():
			owner_entity.target_data.current = null 
	print(owner_entity.metadata.displayname)
	print(owner_entity.target_data.in_range)

func _check_overlap(base_entity):
	if has_overlapping_bodies() && get_overlapping_bodies().has(base_entity.appearence) && !owner_entity.target_data.in_range.has(base_entity):
			owner_entity.target_data.in_range.append(base_entity)

func set_layer(mode : detection_mode = detection_mode.ENEMIESONLY):
		match mode:
			detection_mode.ENEMIESONLY:
				if owner_entity.team == BaseEntity.team_id.PLAYER:
					collision_mask = 16
				else: 
					collision_mask = 8
			detection_mode.ALLIESONLY:
				if owner_entity.team == BaseEntity.team_id.PLAYER:
					collision_mask = 8
				else: 
					collision_mask = 16
			detection_mode.ALLENTITIES:
				collision_mask = 0b11000


func _init(detection_range : float):
	radius = detection_range
	collision_layer = 0
	monitoring = true
	monitorable = false
	var col_shape = CollisionShape2D.new()
	col_shape.shape = CircleShape2D.new()
	col_shape.shape.radius = radius
	add_child(col_shape)
