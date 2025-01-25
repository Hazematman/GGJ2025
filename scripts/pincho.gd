extends Area3D

func _on_body_entered(body: Node3D) -> void:
	body.get_parent().emit_signal("mata")
	body.emit_signal("mata")
