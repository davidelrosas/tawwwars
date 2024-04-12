extends Node

func _ready():
	var towar = Towar.new(Towar.towar_model.TURRET)
	add_child(towar)
	self.get_child(0).position = Vector2(100,200)

func _input(event):
	if event.is_action_pressed("ActionSet2"):
		var bullet = preload("res://Towars/prefabs/projectile.tscn").instantiate()
		bullet.position = get_viewport().get_mouse_position()
		add_child(bullet)
	pass
