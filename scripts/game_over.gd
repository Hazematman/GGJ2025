extends Control

var next: PackedScene = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Siguente.grab_focus()
