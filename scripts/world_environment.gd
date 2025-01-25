extends WorldEnvironment


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	environment.sky.sky_material.panorama = $SubViewport.get_texture()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
