extends Area2D


var touching_player = false
var player : CharacterBody2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		body.get_hurt()
		player = body
		touching_player = true

func _physics_process(delta: float) -> void:
	if touching_player:
		player.get_hurt()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("players"):
		touching_player = false
