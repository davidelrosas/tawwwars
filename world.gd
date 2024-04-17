extends Node

var towar = Towar.new(Towar.towar_model.TURRET)
var towar1 = Towar.new(Towar.towar_model.HEALER)
var mob = Mob.new(Mob.mob_type.BOSSMAN)

func _ready():
	mob.position = Vector2(800,800)
	mob.appearence.target.current = towar
	print(mob.appearence.target.current)
	towar.position = Vector2(300,100)
	towar1.position = Vector2(100,100)
	add_child(towar)
	add_child(mob)
	add_child(towar1)
	
	#target of the spawner set on specific lvl
	$spawner.enemy_target.current = towar


func _input(event):
	if event.is_action_pressed("Use"):
		var towar4 = Towar.new(Towar.towar_model.WALL)
		towar4.position = get_viewport().get_mouse_position()
		add_child(towar4)
