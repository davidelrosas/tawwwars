const classi = Metadata.Classification

class EntityData:
	var stats : Stats
	var team_id : BaseEntity.team
	var active : PackedScene


static var towar_database = {
	Towar.towar_model.TURRET : EntityData.new(),
	Towar.towar_model.HEALER : EntityData.new(),
	Towar.towar_model.WALL : EntityData.new(),
	Towar.towar_model.OBELISK : EntityData.new(),
	Towar.towar_model.GOO : EntityData.new()
	}

static var mob_database =  {
	Mob.mob_type.ALLEN : EntityData.new(),
	Mob.mob_type.BOSSMAN : EntityData.new()
}

static var catalog = {
	Towar.towar_model.TURRET : Metadata.new(&"Basic Turret", classi.Offense, "It shoots", 200, preload("res://Towars/Sprites/watch_tower.svg"),preload("res://Towars/prefabs/turret.tscn")),
	Towar.towar_model.HEALER : Metadata.new(&"Healer", classi.Support, "It Heals", 400, preload("res://Towars/Sprites/tower_round_flag.svg"),preload("res://Towars/prefabs/healer.tscn")),
	Towar.towar_model.WALL : Metadata.new(&"Basic Wall", classi.Defense, "It's just there", 300, preload("res://Towars/Sprites/tower_square.svg"),preload("res://Towars/prefabs/wall.tscn")),
	Towar.towar_model.OBELISK : Metadata.new(&"ObelisK", classi.Offense, "shoots exploding bullet", 800, preload("res://Towars/Sprites/tower_round_flag.svg"),preload("res://Towars/prefabs/obelisk.tscn")),
	Towar.towar_model.GOO : Metadata.new(&"Goo Towar", classi.Defense, "sets a puddle of goo", 500, preload("res://Towars/Sprites/tower_square.svg"),preload("res://Towars/prefabs/goo.tscn"))
}

#get metadata about a specific towar
static func get_info(model : Towar.towar_model, entry : String):
	match entry:
		"Name":
			return catalog[model].displayname
		"Description":
			return catalog[model].description
		"Cost":
			return str(catalog[model].cost)
		"Icon":
			return catalog[model].icon
		"Class":
			return catalog[model].classi
