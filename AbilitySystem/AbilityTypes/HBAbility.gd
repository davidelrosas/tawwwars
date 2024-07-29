class_name HBAbility

extends Ability

@export var hitbox : HitBox
@export var hitbox_mode : HitBox.mode
@export var movement_engine : MovementEngine
@export var cast_position_id : cast_position
# para el explosive shot hacer que trigeree la siguiente habilidad cuando llegue a un vector
@export_flags("TIMED:1","IMPACT_DETECTION:2") var mode = 0
@export var max_impacts : int
@export var speed : float

enum cast_position {ONTARGET, ONSELF}
#var vector_offset

func _ready():
	super._ready()

func cast(target_data = owner_entity.target_data, caster = owner_entity):
	super.cast(target_data, caster)

func execute(target_data, caster):
	
	var pack_ability = PackedScene.new()
	pack_ability.pack(self)
	for i in target_data.current_targets:
		var duplicate = pack_ability.instantiate()
		
		duplicate.initialize_effects(caster)
		duplicate.set_hitbox(caster)
		if mode & 1:
			duplicate.set_timer(duration)
		if mode & 2:
			duplicate.set_impact_detection(caster)
		duplicate.set_as_top_level(true)
		
		match cast_position_id:
			cast_position.ONTARGET:
				duplicate.global_position = i.global_position
			cast_position.ONSELF:
				duplicate.global_position = caster.global_position
		#Abilities will move in the level above casters, sometimes tho be attached to EntitiesItself
		if movement_engine != null:
			duplicate.movement_engine.set_properties(speed,i.global_position - duplicate.global_position, i, duplicate)
		caster.get_parent().add_child(duplicate)
		# maybe add a timed multicast option as wellduplicate

func set_hitbox(caster : BaseEntity):
	hitbox.effects_list = self.effects_list
	hitbox.set_layer(caster.team_id, hitbox_mode)
	#set_hitbox behaviour so (mode)

func set_impact_detection(caster : BaseEntity):
	hitbox.hitbox_hit.connect(_on_impact_detection)

func _on_impact_detection(body : BaseEntity):
	if hitbox.collision_layer == body.hurtbox.collision_mask:
		max_impacts -= 1
		if max_impacts <= 0:
			queue_free()
