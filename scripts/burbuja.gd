extends CharacterBody3D

const SPEED = 1.0

var attractor: Node3D = null

signal mata


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if attractor != null:
		if not attractor.attracting:
			attractor = null
		else:
			var nueva_direction = (attractor.position - position).normalized()
			velocity = SPEED * nueva_direction
			
	if attractor == null:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	move_and_slide()


func _on_area_3d_area_entered(area: Area3D) -> void:
	# Perform attracion to player
	var jugador = area.get_parent()
	attractor = jugador

func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.get_parent() == attractor:
		attractor = null


func _on_mata() -> void:
	print("Estoy muerto")
	get_parent().remove_child(self)
	queue_free()
