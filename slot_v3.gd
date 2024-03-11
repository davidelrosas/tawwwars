extends Node2D

var slot_occ = 0
var new_towar

func _on_button_pressed():
	SignalBus.open_shop.emit(position,self)

func _ready():
	SignalBus.build_towar.connect(_build_towar)

func _build_towar(towar,ref):
	if ref == self:
		
		if (slot_occ == 0):
			new_towar = towar.instantiate()
			new_towar.position = $Sprite2D.position
			add_child(new_towar)
			slot_occ += 1
		
		else:
			$".".remove_child(new_towar)
			slot_occ = 0

