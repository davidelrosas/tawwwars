extends TextureProgressBar

func _ready():
	owner.set_meta(&"HealthComponent", self)
	
func effect(effect : HealthEffect):
	value = min(value - effect.power, max_value)
	if effect.power > 0:
		damage(effect)
	
	else:
		heal(effect)
	

#damage function
func damage(attack: HealthEffect):
	print(value)
	if value <= 0:
		death()

#heal function
func heal(heal: HealthEffect):
	pass

# death function
func death():
		SignalBus.death.emit(self)
		get_parent().queue_free()

# register health
func set_health(health):
	max_value = health
	value = health
	print("wassup")
