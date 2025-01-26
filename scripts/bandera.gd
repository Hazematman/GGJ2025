extends Area3D

@export var level: Node3D = null

func _on_body_entered(body: Node3D) -> void:
	print("Bandera collision")
	body.get_parent().emit_signal("gana")
	body.get_parent().get_parent().emit_signal("gana")
	
	if level != null:
		level.emit_signal("gana")
