extends "res://Towars/scripts/towar_class.gd"


func _ready():
	mouse_entered.connect(_on_mouse_entered)
	towar_constructor(100,50,[23,32],towar_type.attack_towar)


func _on_mouse_entered():
	if $".".has_method("takes_damage"):
		var attack1 = HealthEffect.new()
		attack1.attack_damage = 15
		$".".takes_damage(attack1)
