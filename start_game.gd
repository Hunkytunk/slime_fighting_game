extends Button

var original_text
@export_file var map

func _ready():
	original_text = text


func _process(delta: float) -> void:
	var new_text = original_text
	for i in range(int(floor(sin(Time.get_ticks_msec()*PI/1800)*10))):
		new_text = new_text + "!"
	text = new_text


func _on_pressed() -> void:
	get_tree().change_scene_to_file(map)
