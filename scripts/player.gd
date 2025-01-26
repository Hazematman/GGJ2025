extends CharacterBody3D

const SPEED = 1.0
const JUMP_VELOCITY = 2.0

var RIGHT_DIR = (Vector3.RIGHT + Vector3.FORWARD).normalized()
var UP_DIR = (Vector3.RIGHT + Vector3.BACK).normalized()

signal mata

var attracting = false
var expulsing = false

func _physics_process(delta: float) -> void:
	# no processa Input si estamos en el menu
	var padre = get_parent()
	if "menu" in padre and padre.menu:
		return
		
	if Input.is_action_pressed("attract"):
		attracting = true
	else:
		attracting = false
	
	if Input.is_action_pressed("expulse"):
		expulsing = true
	else:
		expulsing = false
		
	if Input.is_action_pressed("expulse") or Input.is_action_pressed("attract"):
		$Area3D/MeshInstance3D.show()
		$Area3D.monitorable = true
	else:
		$Area3D/MeshInstance3D.hide()
		$Area3D.monitorable = false
	
	# Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta
		
	# Un basis (3x3 matrix) para mover correcto en la perspectiva isometrico
	var iso_basis := Basis(RIGHT_DIR, Vector3.UP, UP_DIR)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (iso_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = move_toward(velocity.x, direction.x, SPEED)
		velocity.z = move_toward(velocity.z, direction.z, SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	var dir2d = Vector2()
	# usa el raton para la direcion
	if len(Input.get_connected_joypads()) == 0:
		var mouse = get_viewport().get_mouse_position()
		var center = get_viewport().get_camera_3d().unproject_position(global_position)
		
		dir2d = center - mouse
	else:
		dir2d = Input.get_vector("look_right", "look_left", "look_down", "look_up")
		
	var dir_rotate = dir2d.rotated(deg_to_rad(-45))
	var dir_3d = Vector3(dir_rotate.x, 	basis.z.y, dir_rotate.y)
	look_at(global_position + dir_3d, Vector3.UP)

	# El jugador no puede mover en la direcion arriba o bajo
	velocity.y = 0
	move_and_slide()
	
func _on_mata() -> void:
	print("Estoy muerto")
	get_parent().remove_child(self)
	queue_free()


func _on_area_3d_body_entered(body: Node3D) -> void:
	pass # Replace with function body.


func _on_area_3d_body_exited(body: Node3D) -> void:
	pass # Replace with function body.
