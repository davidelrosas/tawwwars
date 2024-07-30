extends Node2D

@onready var navmap : RID = NavigationServer2D.map_create()

func _ready():
	NavigationServer2D.map_set_active(navmap,true)
	$NaviMap.update_navi(navmap)
	$spawner.navimap = navmap
	$spawner.posManapool = $Manapool.global_position
	
	#var MapCollision = StaticBody2D.new()
	#var polygon = CollisionPolygon2D.new()
	#polygon.polygon = $NaviMap.polygon
	#MapCollision.add_child(polygon)
	#add_child(MapCollision)
