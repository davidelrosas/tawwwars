extends TextureProgressBar

func _on_value_changed(value):
	if value == 0:
		get_parent().queue_free()
