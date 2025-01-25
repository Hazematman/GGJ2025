extends StaticBody3D

@export var poder: float = 10

func _on_body_entered(body: Node3D) -> void:
	print("Jugador collision")
	body.velocity += poder * -(basis * Vector3.FORWARD)
