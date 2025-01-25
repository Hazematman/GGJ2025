extends Area3D

@export var target: Node3D = null

var listo = false

func _process(delta: float) -> void:
	if listo and Input.is_action_pressed("Interactuar"):
		target.emit_signal("activar")	

func _on_body_entered(body: Node3D) -> void:
	listo = true

func _on_body_exited(body: Node3D) -> void:
	listo = false
