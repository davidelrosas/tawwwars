extends Node2D

var period = 2
var elapsed = 0
var spawnarea = position

# spawnlist example: "mob:3,orc:2"
func spawn_enemy(spawnlist, target):
	spawnlist = spawnlist.split(",")
	var proto
	var enemies = []
	for x in spawnlist:
		var spawngroup = x.split(":")
		match spawngroup[0]:
			"mob":
				proto = preload("res://enemy.tscn")
			"mib":
				proto = preload("res://enemy.tscn")
			_:
				print("invalid enemy type")
		for y in range(spawngroup[1].to_int()):
			var newmob = proto.instantiate()
			newmob.get_node("body").target = target
			enemies.push_back(newmob)
			add_child(newmob)
	return enemies
	
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
		spawn_enemy("mob:3,mib:1",Vector2(200,200))
	pass
