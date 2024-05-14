class_name Healthbar

extends TextureProgressBar

var looks

func _init():
	texture_under = preload("res://assets/sprites/health.png")
	texture_progress = preload("res://assets/sprites/health.png")
	tint_under = Color(1,0,0)
	tint_progress = Color(0,1,0)
	z_index = 1
