extends CharacterBody3D

const SPEED = 1.0
const JUMP_VELOCITY = 1.0

var RIGHT_DIR = (Vector3.RIGHT + Vector3.FORWARD).normalized()
var UP_DIR = (Vector3.RIGHT + Vector3.BACK).normalized()

signal mata

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Un basis (3x3 matrix) para mover correcto en la perspectiva isometrico
	var iso_basis := Basis(RIGHT_DIR, Vector3.UP, UP_DIR)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (iso_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
func _on_mata() -> void:
	print("Estoy muerto")
	get_parent().remove_child(self)
	queue_free()
