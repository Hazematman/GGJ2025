extends StaticBody3D

var puede_interactuar

func _ready() -> void:
	puede_interactuar = false

func _on_body_exited(body: Node3D) ->void:
	print("Jugador sale")
	puede_interactuar = false

func _on_body_entered(body: Node3D) -> void:
	print("Jugador collision")
	puede_interactuar = true

func _input(ev):
	if Input.is_action_pressed("Interactuar"):
		if puede_interactuar == true:
			get_tree().change_scene_to_file("res://scenes/game.tscn")
