class_name AttackTowar

extends Towar

const type = towar_type.ATTACK
var model : towar_model
const projectile = preload("res://Towars/prefabs/projectile.tscn")

class metadata1:
	var namestr
	var description
	var cost
	var sprite
	var scriptee

# Attack Towar Models Metadata
var metadata := {
	towar_model.BASICATTACK: {
		"Name": "Basic Attack Towar",
		"Description": "kinda booring",
		"Cost": 300,
		"Sprite": preload("res://Towars/Sprites/watch_tower.svg")
		
	},
	towar_model.OBELISK: {
		"Name": "Obelisk",
		"Description": "Shoots a lazerbeam",
		"Cost": 1000,
		"Sprite": preload("res://Towars/Sprites/obelisk.svg")
	},
	towar_model.BOMBER: {
		"Name": "Bomber",
		"Description": "It goes BOOM",
		"Cost": 700,
		"Sprite": preload("res://Towars/Sprites/turret.svg")
	},
	"five": metadata1.new()
}

#enums
enum towar_model {BASICATTACK, OBELISK, BOMBER}

#functions
func hello():
	print("hello")

#class constructor
func _init(model : towar_model):
	match model:
		towar_model.BASICATTACK:
			super._init(100,50,[20,20])
		towar_model.OBELISK:
			super._init(70,100,[15,30])
		towar_model.BOMBER:
			super._init(200,20,[15,30])
			

func shoot(dir : Vector2, something):
	print("helo")
	var new_proj = projectile.instantiate()
	new_proj.apply_impulse(dir.normalized() * 1000)
	something.add_child(new_proj)

var rotato = 0
func action(something):
	shoot(Vector2(1,0).rotated(rotato),something)
	rotato+=0.2*PI
	pass
