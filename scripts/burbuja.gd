extends RigidBody3D

const SPEED = .1
const MAX_SPEED = 0.35
const RESISTANCE = 0.001
const JUMP_VELOCITY = 2.0
const FORCE = 0.5

var attractor: Node3D = null
var expulsor: Node3D = null

var puede_empujar_jugador = false

signal mata

@export var level: Node3D = null

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta
		
	if attractor != null:
		if (not "attracting" in attractor) or (not attractor.attracting):
			attractor = null
		else:
			var nueva_direction = (attractor.global_position - global_position)
			nueva_direction.y = 0
			nueva_direction = nueva_direction.normalized()
			#if (velocity.length() < MAX_SPEED):
			#	velocity += SPEED * nueva_direction
			apply_force(nueva_direction)
			
	if expulsor != null:
		if (not "expulsing" in expulsor) or (not expulsor.expulsing):
			expulsor = null
		else:
			var nueva_direction = (expulsor.global_position - global_position)
			nueva_direction.y = 0
			nueva_direction = nueva_direction.normalized()
			
			#if (velocity.length() < MAX_SPEED):
			#	velocity -= SPEED * nueva_direction
			apply_force(-nueva_direction)
						
	#if (attractor == null) and (expulsor == null):
	#	velocity.x = move_toward(velocity.x, 0, SPEED/100)
	#	velocity.z = move_toward(velocity.z, 0, SPEED/100)
	
	#var velocity_before = velocity
	#velocity.y = 0
	# hay collision
	#var col = move_and_collide(delta * velocity)
	#if col:
	#	velocity = velocity.bounce(col.get_normal())
	#	
	#	var collider = col.get_collider()
	#	if collider is RigidBody3D:
	#		collider.apply_force(col.get_normal() * -FORCE)
	
	if linear_velocity.length() > MAX_SPEED:
		linear_velocity = linear_velocity.limit_length(MAX_SPEED)


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
	#if Input.is_action_pressed("Interactuar"):
	#	if puede_empujar_jugador == true:
	#		var nueva_direction = (expulsor.global_position - global_position).normalized()
	#		velocity -= SPEED * nueva_direction * 100
	pass

func _on_mata() -> void:
	$DieSound.play()
	self.hide()
	
	if level != null:
		level.emit_signal("mata")
