extends Control

var towar_model : Towar.towar_model

const Catalog = preload("res://Shop/catalog.gd")
#Sets metadata of towar into card
func set_info(towar_model : Towar.towar_model):
	$frontside/Name.text = Catalog.get_info(towar_model, "Name")
	$backside/Description.text = Catalog.get_info(towar_model, "Description")
	$frontside/Sprite2D.texture = Catalog.get_info(towar_model, "Icon")
	$frontside/PriceTag.text = Catalog.get_info(towar_model, "Cost")
	
	self.towar_model = towar_model

#maybe use has_method()
func _on_create_pressed():
	SignalBus.build_towar.emit(Catalog.catalog[towar_model].scene.instantiate())

func _on_flip_pressed():
	$backside.visible = not $backside.visible
	
