extends Area2D

var health_effect = HealthEffect.new()

func _on_body_entered(body):
	if body.get_parent().has_method("effect"):
		body.get_parent().effect(health_effect)
	queue_free()
