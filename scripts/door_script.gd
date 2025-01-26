extends Area3D

@export var target: Node3D = null

func _on_body_entered(body: Node3D) -> void:
	if target != null:
		target.get_parent().remove_child(target)
