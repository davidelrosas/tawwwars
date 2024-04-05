extends Control

var towar_type : Towar.towar_type
var towar_model_id = 0
var towar = preload("res://Towars/prefabs/base_towar.tscn")

#Sets metadata of towar into card
func set_card_info(type : Towar.towar_type, model_id):
	towar_type = type
	towar_model_id = model_id
	var towar_subclass = load(Towar.script_paths[towar_type])
	var towar_metadata = towar_subclass.metadata
	
	$frontside/Name.text = towar_metadata[towar_model_id]["Name"]
	$backside/Description.text = towar_metadata[towar_model_id]["Description"]
	$frontside/Sprite2D.texture = towar_metadata[towar_model_id]["Sprite"]
	$frontside/PriceTag.text = str(towar_metadata[towar_model_id]["Cost"])

#maybe use has_method()
func _on_create_pressed():
	var new_towar = towar.instantiate()
	new_towar.set_data(towar_type, towar_model_id)
	add_child(new_towar)

func _on_flip_pressed():
	$backside.visible = not $backside.visible
	
