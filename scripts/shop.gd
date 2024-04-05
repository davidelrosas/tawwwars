extends Sprite2D

var current_slot_ref
var counter = 0
var attack_towar_subclass = preload("res://Towars/scripts/attack_towar_subclass.gd")


func _ready() -> void:
	SignalBus.open_shop.connect(_open_shop)

func _on_button_pressed():
	SignalBus.build_towar.emit(Towar.towar_type.ATTACK,current_slot_ref)

func _on_button_2_pressed():
	pass # Replace with function body.

func _on_button_3_pressed():
	pass # Replace with function body.


func _open_shop(slot_position,slot_ref):
	
	if current_slot_ref != slot_ref || counter == 1:
		visible = true
		position = slot_position + Vector2(0.0,+ 150.0)  
		current_slot_ref = slot_ref
		counter = 0
	
	elif current_slot_ref == slot_ref:
		visible = false
		counter = 1
	
