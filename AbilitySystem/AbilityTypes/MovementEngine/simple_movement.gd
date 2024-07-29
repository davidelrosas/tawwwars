class_name SimpleMovement

extends MovementEngine

func _ready():
	direction = (target.position - ability.position).normalized()

func _physics_process(delta):
	ability.position += direction * speed * delta
	pass

