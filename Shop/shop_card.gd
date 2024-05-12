extends Control

#var towar_model : Towar.towar_model
#var towar = preload("res://Towars/prefabs/base_towar.tscn")

#Sets metadata of towar into card
func set_info(towar_model : Towar.towar_model):
	$frontside/Name.text = Towar.get_info(towar_model, "Name")
	$backside/Description.text = Towar.get_info(towar_model, "Description")
	$frontside/Sprite2D.texture = Towar.get_info(towar_model, "Icon")
	$frontside/PriceTag.text = Towar.get_info(towar_model, "Cost")
	
	#self.towar_model = towar_model

#maybe use has_method()
func _on_create_pressed():
	pass

func _on_flip_pressed():
	$backside.visible = not $backside.visible
	
