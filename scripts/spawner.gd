extends Node2D

var period = 2
var elapsed = 0
var spawnarea = position
@export var enemy_target : Vector2 = Vector2(0,0)
@export var concurrent_spawns : int = 10

var spawned = []

func n_can_spawn() -> int:
	return concurrent_spawns - spawned.size()

# spawnlist example: "mob:3,orc:2"
func spawn_enemy(spawnlist, target):
	spawnlist = spawnlist.split(",")
	var proto
	for x in spawnlist:
		var spawngroup = x.split(":")
		match spawngroup[0]:
			"mob":
				proto = preload("res://prefabs/enemy.tscn")
			"mib":
				proto = preload("res://prefabs/enemy.tscn")
			_:
				print("invalid enemy type")
		for y in range(min(spawngroup[1].to_int(),n_can_spawn())):
			var newmob = proto.instantiate()
			newmob.global_position = spawnarea
			newmob.target = enemy_target
			spawned.push_back(newmob)
			add_child(newmob)
	pass
	
func spread(enemylist):
	
	pass
	
# Call this function to spawn a new node
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	elapsed += delta
	if (elapsed>=period):
		elapsed-= period
		spawn_enemy("mob:3,mib:1",enemy_target)
	pass
