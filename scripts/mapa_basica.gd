extends Node3D

@export var editor: Node = null

const game_over_screen = preload("res://scenes/game_over.tscn")

signal mata

func _on_mata() -> void:
	print("Murio el player")
	get_parent().add_child(editor)
	get_parent().remove_child(self)
	queue_free()
