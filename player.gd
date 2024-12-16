extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -600.0
signal hurt
var life = 7
@export var bullet : PackedScene

func _physics_process(delta: float) -> void:
	movement(delta)

func movement(delta: float):
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
		if (direction > 0 and $VideoStreamPlayer.scale.x > 0) or (direction < 0 and $VideoStreamPlayer.scale.x < 0):
			$VideoStreamPlayer.scale.x = -1 * $VideoStreamPlayer.scale.x
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func shoot(pos):
	var bullet_instance : CharacterBody2D = bullet.instantiate()
	var shooting_direction : Vector2 = pos - global_position
	bullet_instance.velocity = shooting_direction.normalized()
	bullet_instance.global_position = global_position
	get_parent().add_child(bullet_instance)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		shoot(event.position)
	elif event is InputEventMouseMotion:
		$player_assault_rifle.look_at(event.position)
		$player_assault_rifle.rotation += PI/4
		if event.global_position < $player_assault_rifle.global_position:
			$player_assault_rifle.rotation += PI/2
			$player_assault_rifle.flip_h = true
		else:
			$player_assault_rifle.flip_h = false

var invulnerable = false
func get_hurt():
	if life == 0 or invulnerable:
		return
	invulnerable = true
	$invulnerable_timer.start()
	$AudioStreamPlayer.play()
	life -= 1
	hurt.emit()


func _on_invulnerable_timer_timeout() -> void:
	invulnerable = false
