extends Node

var towar = Towar.new(Towar.towar_model.TURRET)
var mob = Mob.new(Mob.mob_type.BOSSMAN)

func _ready():
	mob.position = Vector2(1000,1000)
	towar.position = Vector2(500,100)
	add_child(towar)
	add_child(mob)
	
	#will be handled better by targeting system
	towar.target_data.closest = mob.get_child(0)
	

func _physics_process(delta):
	pass
