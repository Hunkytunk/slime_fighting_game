extends Button


@export_file var map

func _on_pressed() -> void:
	get_tree().change_scene_to_file(map)
