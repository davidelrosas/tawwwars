extends CanvasLayer

var shop_open : bool
var card = preload("res://Shop/shop_card.tscn")


func _ready():
	switch()
	pass

func switch():
	var new_card = card.instantiate()
	new_card.set_info(Towar.towar_model.HEALER)
	add_child(new_card)
	pass

func _on_shop_pressed():
	if shop_open == false:
		$"open_close shop".play("open")
		shop_open = true
	else:
		$"open_close shop".play("close")
		shop_open = false
