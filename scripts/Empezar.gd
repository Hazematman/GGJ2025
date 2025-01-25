extends StaticBody3D

var puede_interactuar = false
	
func _on_body_entered(body: Node3D) -> void:
	print("Jugador collision")
	puede_interactuar = true
	
