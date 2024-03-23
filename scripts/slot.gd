extends Node2D

var slot_occ = false
var new_towar
var child_towar_ref

func _on_button_pressed():
	SignalBus.open_shop.emit(position,self)

func _ready() -> void:
	SignalBus.build_towar.connect(_build_towar)
	SignalBus.towar_death.connect(_change_status)
	
func _change_status(towar_ref):
	if child_towar_ref == towar_ref:
		slot_occ = false


func _build_towar(towar, type, slot_ref):
	if slot_ref == self:
		
		if (slot_occ == false):
			
			new_towar = towar.instantiate()
			new_towar.towar_type = type
			new_towar.position = $Sprite2D.position
			add_child(new_towar)
			
			child_towar_ref = new_towar
			slot_occ = true
			
		
		else:
			$".".remove_child(new_towar)
			slot_occ = false

