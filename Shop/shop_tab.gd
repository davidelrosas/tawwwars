extends Control

const ShopCard = preload("res://Shop/shop_card.gd")
const Catalog = preload("res://Shop/catalog.gd")

var cards : Array[ShopCard]

static func sort_func( card1 : ShopCard, card2 : ShopCard,attribute : String) -> bool:
	return Catalog.get_info(card1.towar_model,attribute) <= Catalog.get_info(card2.towar_model,attribute)

func add_card(card : ShopCard) :
	cards.insert(cards.bsearch_custom(card,sort_func.bind("Cost")),card)
	add_child(card)
	update_offsets()
	
func update_offsets():
	for c in range(cards.size()):
		cards[c].offset_left = 120 * c
