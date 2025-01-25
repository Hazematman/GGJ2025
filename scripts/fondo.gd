extends Node3D

const fondo = [10.0, 8, -5, 4, 7, 2, -9, -2, 6]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Sprite3D.region_rect.position.x += fondo[0] * delta
	$Sprite3D.region_rect.position.y += fondo[0] * delta
	$Sprite3D2.region_rect.position.x += fondo[1] * delta
	$Sprite3D2.region_rect.position.y += fondo[1] * delta
	$Sprite3D3.region_rect.position.x += fondo[2] * delta
	$Sprite3D3.region_rect.position.y += fondo[2] * delta
	$Sprite3D4.region_rect.position.x += fondo[3] * delta
	$Sprite3D4.region_rect.position.y += fondo[3] * delta
	$Sprite3D5.region_rect.position.x += fondo[4] * delta
	$Sprite3D5.region_rect.position.y += fondo[4] * delta
	$Sprite3D6.region_rect.position.x += fondo[5] * delta
	$Sprite3D6.region_rect.position.y += fondo[5] * delta
	$Sprite3D7.region_rect.position.x += fondo[6] * delta
	$Sprite3D7.region_rect.position.y += fondo[6] * delta
	$Sprite3D8.region_rect.position.x += fondo[7] * delta
	$Sprite3D8.region_rect.position.y += fondo[7] * delta
	$Sprite3D9.region_rect.position.x += fondo[8] * delta
	$Sprite3D9.region_rect.position.y += fondo[8] * delta
