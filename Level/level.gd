extends Node2D

@onready var navmap : RID = NavigationServer2D.map_create()

func _ready():
	NavigationServer2D.map_set_active(navmap,true)
