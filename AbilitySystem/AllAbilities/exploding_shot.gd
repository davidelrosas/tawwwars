extends Node2D

@export var hitbox : HitBox
@export var impact_detector : Area2D
@export var effects_list : Array[CombatEffect]
@export var speed : float

@export var ability_next : PackedScene

var direction : Vector2
var target : BaseEntity
var caster : BaseEntity

func _ready():
	impact_detector.body_entered.connect(_on_impact_detection)
	set_as_top_level(true)

@warning_ignore("shadowed_variable")
func cast(target_data : Target, caster : BaseEntity):
	target_data.find([Target.target_type.CLOSEST],[1])
	if target_data.current_targets != []:
		shoot(caster)
	else:
		print("no target in sight")

@warning_ignore("shadowed_variable")
func shoot(caster):
	hitbox.effects_list = effects_list
	hitbox.set_layer(caster.team_id)
	# we need to think about this physics layer
	impact_detector.collision_layer = 0
	impact_detector.collision_mask = caster.det_area.collision_mask
	
	#wtf is this for
	self.caster = caster
	position = caster.global_position
	var target = caster.target_data.target_list.pop_back()
	direction = (target.global_position - caster.global_position).normalized()
	
	caster.get_parent().add_child(self)


func _physics_process(delta):
	look_at(target.global_position)
	global_position += direction * speed * delta


func _on_impact_detection(body):
	print("yo")
	if hitbox.collision_layer == body.get_node("HurtBox").collision_mask:
		end_ability()

func end_ability():
	if ability_next:
		var next_part = ability_next.instantiate()
		next_part.target = target
		#this needs to be done after flushing queries
		next_part.call_deferred("execute", caster)
	
	queue_free()
