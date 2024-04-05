extends CanvasLayer

var shop_open : bool
var shop_cycle : Towar.towar_type
var card = preload("res://Shop/shop_card.tscn")


func _ready():
	pass

func switch():
	var new_card = card.instantiate()
	new_card.set_card_info(Towar.towar_type.ATTACK,1)
	add_child(new_card)
	pass

func _on_shop_pressed():
	if shop_open == false:
		$"open_close shop".play("open")
		shop_open = true
	else:
		$"open_close shop".play("close")
		shop_open = false
