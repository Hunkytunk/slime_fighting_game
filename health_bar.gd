extends HBoxContainer


@export var heart : PackedScene
@export var player : CharacterBody2D
var hearts : Array[Panel] = []
@onready var current_life = player.life

func _ready() -> void:
	for life in player.life:
		var heart_instance : Panel = heart.instantiate()
		var animated_sprite : AnimatedSprite2D = heart_instance.get_node("AnimatedSprite2D")
		animated_sprite.play()
		hearts.append(heart_instance)
		add_child(heart_instance)
	player.hurt.connect(_on_hurt)

func _on_hurt(by):
	var lower = mini(player.life, current_life)
	var upper = maxi(player.life, current_life)
	for i in range(lower, upper):
		var animated_sprite : AnimatedSprite2D = hearts[i].get_node("AnimatedSprite2D")
		animated_sprite.play("empty")
