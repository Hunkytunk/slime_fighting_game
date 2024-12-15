extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
signal hurt(by)
var life = 3

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_pressed("ui_down"):
		set_collision_mask_value(3, false)
	else:
		set_collision_mask_value(3, true)

	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		if (direction > 0 and scale.y > 0) or (direction < 0 and scale.y < 0):
			scale.x = -1 * scale.x
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
