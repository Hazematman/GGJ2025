extends Area3D

@export var target: Node3D = null

var listo = false

func _process(delta: float) -> void:
	if listo and Input.is_action_just_pressed("Interactuar") and target != null:
		if target.has_user_signal("activar"):
			target.emit_signal("activar")
		else:
			target.get_parent().remove_child(target)
			target.queue_free()
		target = null

func _on_body_entered(body: Node3D) -> void:
	listo = true

func _on_body_exited(body: Node3D) -> void:
	listo = false
