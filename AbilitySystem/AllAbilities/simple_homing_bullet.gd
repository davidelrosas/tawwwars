extends Node2D

@export var hitbox : HitBox
@export var impact_detector : Area2D
@export var effects_list : Array[CombatEffect]
@export var speed : float

var direction : Vector2
var target : BaseEntity
var caster : BaseEntity


func _ready():
	impact_detector.body_entered.connect(_on_impact_detection)
	set_as_top_level(true)

func cast(target_data : Target, caster : BaseEntity):
	target = target_data.find_closest(caster)
	if target != null:
		shoot(caster)
	else:
		print("no target in sight")

func shoot(caster):
	hitbox.effects_list = effects_list
	hitbox.set_layer(caster.team_id)
	# we need to think about this physics layer
	impact_detector.collision_layer = 0
	impact_detector.collision_mask = caster.det_area.collision_mask
	
	self.caster = caster
	position = caster.global_position
	direction = (target.global_position - caster.global_position).normalized()
	
	caster.get_parent().add_child(self)

func _physics_process(delta):
	if not target:
		global_position += direction * speed * delta
	
	else:
		look_at(target.global_position)
		global_position = global_position.move_toward(target.global_position, speed*delta)
		

func _on_impact_detection(body):
	print("yo")
	if hitbox.collision_layer == body.get_node("HurtBox").collision_mask:
		queue_free()
