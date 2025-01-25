extends CharacterBody3D

const SPEED = 0.01
const MAX_SPEED = 3.0
const POP_SPEED = 2.5

var attractor: Node3D = null
var expulsor: Node3D = null

var puede_empujar_jugador = false

signal mata


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if attractor != null:
		if (not attractor.attracting) or (velocity.length() > MAX_SPEED):
			attractor = null
		else:
			var nueva_direction = (attractor.global_position - global_position).normalized()
			if (velocity.length() < MAX_SPEED):
				velocity += SPEED * nueva_direction
			
	if expulsor != null:
		if (not expulsor.expulsing) or (velocity.length() < -MAX_SPEED):
			expulsor = null
		else:
			var nueva_direction = (expulsor.global_position - global_position).normalized()
			if (velocity.length() < MAX_SPEED):
				velocity -= SPEED * nueva_direction
						
	if (attractor == null) and (expulsor == null):
		velocity.x = move_toward(velocity.x, 0, SPEED/100)
		velocity.z = move_toward(velocity.z, 0, SPEED/100)
	
	var velocity_before = velocity
	# hay collision
	if move_and_slide():
		var col: PhysicsBody3D = get_last_slide_collision().get_collider()
		# Usa collision_layer para ver si es jugador
		if (col.collision_layer & (1 << 15) == (1 << 15)):
			if velocity_before.length() > POP_SPEED:
				emit_signal("mata")
		
	


func _on_area_3d_area_entered(area: Area3D) -> void:
	# Perform attracion to player
	var jugador = area.get_parent()
	attractor = jugador
	expulsor = jugador

func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.get_parent() == attractor:
		attractor = null
	if area.get_parent() == expulsor:
		expulsor = null	

func _on_body_exited(body: Node3D) ->void:
	print("Jugador sale burbuja")
	puede_empujar_jugador = false

func _on_body_entered(body: Node3D) -> void:
	print("Jugador toca burbuja")
	puede_empujar_jugador = true

func _input(ev):
	if Input.is_action_pressed("Interactuar"):
		if puede_empujar_jugador == true:
			var nueva_direction = (expulsor.global_position - global_position).normalized()
			velocity -= SPEED * nueva_direction * 100

func _on_mata() -> void:
	print("Estoy muerto")
	get_parent().remove_child(self)
	queue_free()
