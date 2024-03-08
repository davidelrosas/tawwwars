extends Node2D

signal open_shop(slot_position)

var slot_occ = 0
var new_towar

func _on_button_pressed():
	open_shop.emit(position)

func _on_shop_build_towar(towar):
		
	if (slot_occ == 0):
		new_towar = towar.instantiate()
		new_towar.position = $Sprite2D.position
		add_child(new_towar)
		slot_occ += 1
		print(slot_occ)
		
	else:
		$".".remove_child(new_towar)
		slot_occ = 0
		print(slot_occ)

