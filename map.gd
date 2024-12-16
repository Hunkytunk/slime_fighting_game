extends Node2D

@export var enemy : PackedScene
@export var player : CharacterBody2D
@export_file var death_screen_path

func _ready() -> void:
	player.hurt.connect(_on_player_hurt)
	spawn_enemies(100, true)

var y_shift = []

func spawn_enemies(count, reset_y_shift : bool):
	var locations = $mob_spawners.get_children()
	if reset_y_shift:
		y_shift = []
		for i in range(len(locations)):
			y_shift.append(0)
	for i in range(count):
		var location = randi_range(0, len(locations)-1)
		var enemy_instance : CharacterBody2D = enemy.instantiate()
		enemy_instance.position = Vector2(0, y_shift[location])
		y_shift[location] -= 100
		locations[location].add_child(enemy_instance)

func _on_player_hurt():
	if player.life == 0:
		get_tree().change_scene_to_file(death_screen_path)
