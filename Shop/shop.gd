extends CanvasLayer

const ShopTab = preload("res://Shop/shop_tab.gd")

var tabs : Array[ShopTab] = []

const Catalog = preload("res://Shop/catalog.gd")

var shop_open : bool
var card = preload("res://Shop/shop_card.tscn")


func on_shop_input(action : String):
	var tc = $TabContainer
	match action:
		"Left" : tc.select_next_available()
		"Right": tc.select_previous_available()

func _ready():
	InputManager.shopActions.input.connect(on_shop_input)
	SignalBus.open_shop.connect(_on_shop_pressed)
	place_cards()

func place_cards():
	for classi in Metadata.Classification:
		var tab = ShopTab.new()
		tab.name = String(classi)
		$TabContainer.add_child(tab)
		tabs.append(tab)
	for type in Catalog.catalog.keys():
		var newcard = card.instantiate()
		newcard.set_info(type)
		tabs[Catalog.catalog[type].classification].add_card(newcard)

func _on_shop_pressed():
	if shop_open == false:
		$"open_close shop".play("open")
		shop_open = true
		set_process(true)
	else:
		$"open_close shop".play("close")
		shop_open = false
		set_process(false)
