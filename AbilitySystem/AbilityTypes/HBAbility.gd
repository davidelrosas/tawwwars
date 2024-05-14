class_name HBAbility

extends Ability

@export var hitbox : HitBox
@export var impact_detector : Area2D
@export var movement_engine : AbilityMovement
@export var cast_position_id : cast_position
# para el explosive shot hacer que trigeree la siguiente habilidad cuando llegue a un vector
@export_flags("TIMED:1","IMPACT_DETECTION:2") var mode = 0
@export var max_impacts : int
@export var speed : float

enum cast_position {ONTARGET, ONSELF}
#var vector_offset

func _ready():
	super._ready()
	print(movement_engine.target,"ready")

func cast(target_data, caster):
	super.cast(target_data, caster)

func execute(target_data, caster):
	super.execute(target_data, caster)
	set_hitbox(caster)
	if mode & 1:
		set_timer(duration)
	if mode & 2:
		set_impact_detection(caster)
	
	set_as_top_level(true)
	
	#need to make this for loop work, duplicates need to be created but they erase the set-properties
	for i in target_data.current_targets:
		var duplicate = self.duplicate()
		match cast_position_id:
			cast_position.ONTARGET:
				global_position = i.global_position
			cast_position.ONSELF:
				global_position = caster.global_position
		#Abilities will move in the level above casters, sometimes tho be attached to EntitiesItself
		if movement_engine != null:
			movement_engine.set_properties(speed,i.global_position - global_position, i, self)
		caster.get_parent().add_child(self)
		# maybe add a timed multicast option as wellduplicate

func set_hitbox(caster : BaseEntity):
	hitbox.effects_list = self.effects_list
	hitbox.set_layer(caster.team_id)
	pass

func set_impact_detection(caster : BaseEntity):
	impact_detector.collision_layer = 0
	impact_detector.collision_mask = caster.det_area.collision_mask
	impact_detector.body_entered.connect(_on_impact_detection)
	pass

func _on_impact_detection(body : BaseEntity):
	if hitbox.collision_layer == body.hurtbox.collision_mask:
		max_impacts -= 1
		if max_impacts <= 0:
			queue_free()
