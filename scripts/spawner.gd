extends Node2D

var elapsed = 0
var spawnarea = global_position

var navimap : RID

@export var concurrent_spawns : int = 10

@export var spawn_schedule : String = "mob:1#1" #"mob:3,mib:1#2/mob:1,mib:1#1"
@export var loop_spawns : bool

var sp_sch
var posManapool : Vector2

var schedule_index = 0

var spawned = []

static var enemy_types = {
	"mob" : preload("res://Mobs/allen.tscn"),
	"mib" : preload("res://Mobs/bossman.tscn")
}

func n_can_spawn() -> int:
	return concurrent_spawns - spawned.size()

# spawnlist example: "mob:3,orc:2"
func process_spawnlist(spawnlist):
	spawnlist = spawnlist.split(",")
	var newmob_type
	for x in spawnlist:
		var spawngroup = x.split(":")
		if enemy_types.has(spawngroup[0]):
			newmob_type = enemy_types[spawngroup[0]]
		else:
			print("trying to spawn invalid enemy type")
			pass
		for _y in range(min(spawngroup[1].to_int(),n_can_spawn())):
			#spawn enemy
			var newmob = newmob_type.instantiate()
			newmob.global_position = spawnarea
			#temporary fix
			#newmob.target_data.current_targets.append(enemy_target.current_targets.pop_back())
			
			if (navimap):
				newmob.navAgent.set_navigation_map(navimap)
				newmob.posManapool = posManapool
			
			spawned.push_back(newmob)
			add_child(newmob)
	
func spread(enemylist):
	#TODO
	pass
	
func set_spawnschedule(schedule : String):
	sp_sch = schedule.split("/")
	
func _ready():
	set_spawnschedule(spawn_schedule)

func _process(delta):
	elapsed += delta
	
	if (schedule_index < sp_sch.size()):
		var cur = sp_sch[schedule_index].split("#")
		var curperiod = cur[1].to_float()
		if curperiod < elapsed:
			elapsed -= curperiod
			process_spawnlist(cur[0])
			schedule_index += 1 - (int(loop_spawns and schedule_index >= sp_sch.size())*sp_sch.size())
