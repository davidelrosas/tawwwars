extends Sprite2D

var towar1 = preload("res://prefabs/towar.tscn")
var slot_ref
var counter = 0

func _on_button_pressed():
	SignalBus.build_towar.emit(towar1,slot_ref)

func _ready() -> void:
	SignalBus.open_shop.connect(_open_shop)
	
func _open_shop(slot_position,ref):
	
	if slot_ref != ref || counter == 1:
		visible = true
		position = slot_position + Vector2(0.0,+ 150.0)  
		slot_ref = ref
		counter = 0
	
	elif slot_ref == ref:
		visible = false
		counter = 1
	
