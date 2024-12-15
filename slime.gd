extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -600.0

func _physics_process(delta: float) -> void:
	var player : CharacterBody2D = get_tree().get_nodes_in_group("players")[0]
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if player.global_position.y > global_position.y:
		set_collision_mask_value(3, false)
	else:
		set_collision_mask_value(3, true)
	
	if player.global_position.y < global_position.y and is_on_floor():
		if $jump_timer.is_stopped():
			$jump_timer.wait_time = randf_range(0.5, 4)
			$jump_timer.start()
	
	var direction : int
	if player.global_position.x > global_position.x:
		direction = 1
	else:
		direction = -1
	velocity.x = direction * SPEED * randf_range(0.8, 1.0)

	move_and_slide()

func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _on_jump_timer_timeout() -> void:
	velocity.y = JUMP_VELOCITY
	$AudioStreamPlayer.play()
