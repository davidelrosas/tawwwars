extends Sprite2D

signal build_towar(towar)

var towar1 = preload("res://structures/towar.tscn")

func _on_slot_open_shop(slot_position):
	visible = not visible
	position = slot_position + Vector2(0.0,+ 150.0)  


func _on_button_pressed():
	build_towar.emit(towar1)

