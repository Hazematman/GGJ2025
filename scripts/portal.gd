extends Area3D

@export var destino: Node3D
@export var portal_cooldown: float = 0.5

var puede_portal = true

func _ready() -> void:
	assert(destino != null)

func _on_body_entered(body: Node3D) -> void:
	if puede_portal:
		destino.empieza_cooldown()
		body.global_position = destino.global_position
	
func empieza_cooldown() -> void:
	puede_portal = false
	$Timer.start(portal_cooldown)

func _on_timer_timeout() -> void:
	puede_portal = true
