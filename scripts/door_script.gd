extends Area3D

@export var target: Node3D = null

var done = false
func _on_body_entered(body: Node3D) -> void:
	if not done and target != null:
		target.get_parent().remove_child(target)
		done = true
