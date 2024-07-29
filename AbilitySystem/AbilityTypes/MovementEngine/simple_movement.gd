class_name SimpleMovement

extends MovementEngine

func _ready():
	direction = target.position - ability.position

func _physics_process(delta):
	ability.position += direction * speed * delta
	pass

