extends Area3D

func _on_body_entered(body: Node3D) -> void:
	print("Bandera collision")
	body.get_parent().emit_signal("gana")
	body.get_parent().get_parent().emit_signal("gana")
