extends Control


func _on_timer_timeout() -> void:
	Info.score += 69
	self.text = str(Info.score)
	$Timer.start()
