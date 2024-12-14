extends Node2D



func _ready() -> void:
	var a = 12
	var b = 10
	if a > b:
		var c = a
		a = b
		b = c
	for i in range(a, b):
		print("mordi")
