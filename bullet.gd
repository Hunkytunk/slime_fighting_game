extends CharacterBody2D

var SPEED = 500

func _draw() -> void:
	var brown = Color.SADDLE_BROWN
	draw_circle(Vector2(0, 0), 5, brown)

func _physics_process(delta: float) -> void:
	var body = move_and_collide(velocity * SPEED * delta)
	if body:
		body = body.get_collider()
		if body.is_in_group("enemies"):
			body.die()
		queue_free()


func _on_lifetime_timer_timeout() -> void:
	queue_free()
