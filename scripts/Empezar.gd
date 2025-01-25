extends StaticBody3D

var puede_interactuar = false
var cooldown = 0.5

func _process(delta: float) -> void:
	if cooldown > 0:
		cooldown -= delta
	else:
		cooldown = 0

func _on_body_exited(body: Node3D) ->void:
	if cooldown <= 0:
		print("Jugador sale")
		puede_interactuar = false

func _on_body_entered(body: Node3D) -> void:
	if cooldown <= 0:
		print("Jugador collision")
		puede_interactuar = true

func _input(ev):
	if Input.is_action_pressed("Interactuar"):
		if puede_interactuar == true:
			get_tree().change_scene_to_file("res://scenes/game.tscn")
