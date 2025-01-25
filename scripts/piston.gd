extends StaticBody3D

@export var poder: float = 2

signal activar 

var target = null

func _on_activar() -> void:
	if target != null:
		target.velocity += poder * -(basis * Vector3.FORWARD)

func _on_area_3d_body_entered(body: Node3D) -> void:
	target = body

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body == target:
		target = null
