class_name Projectile

extends Node2D

@onready var sprite = $Sprite2D
var hitbox : HitBox

var target : Object
var mode : mode_id
var impact_detector = Area2D.new()

enum mode_id {}

#projectile logic
var speed := 0
var direction = Vector2.ZERO

func _ready():
	set_as_top_level(true)
	look_at(position + direction)
	hitbox = get_node("HitBox")
	
	set_impact_detection()
	impact_detector.body_entered.connect(_on_impact_detection)


#not working properly
func set_impact_detection():
	var col_shape = hitbox.get_node("CollisionShape2D").duplicate()
	impact_detector.add_child(col_shape)
	
	#This can lead to some problems
	impact_detector.collision_layer = 0
	impact_detector.collision_mask = 1
	add_child(impact_detector)

func _physics_process(delta: float):
	if not target:
		position += direction * speed * delta
	
	else:
		#appearence for now because node2d doesnt move only the appearence
		look_at(target.appearence.global_position)
		position = position.move_toward(target.appearence.global_position, speed*delta)

func _on_impact_detection(body : BaseEntity):
	if hitbox.collision_layer == body.get_node("HurtBox").collision_mask:
		queue_free()
