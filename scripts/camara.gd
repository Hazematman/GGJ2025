extends Camera3D

@export var node: Node3D = null
@export var fondo: Node3D = null

var dir = Vector3()
var fondo_original = Vector3()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(node != null)
	dir = position - node.position
	if fondo != null:
		fondo_original = fondo.global_position - node.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if node != null:
		position = node.position + dir
		if fondo != null:
			fondo.global_position = fondo_original + node.global_position
