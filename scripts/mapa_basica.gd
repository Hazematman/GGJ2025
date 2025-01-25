extends Node3D

@export var editor: Node = null

const game_over_screen = preload("res://scenes/game_over.tscn")

signal mata


func _on_mata() -> void:
	print("Murio el player")
	var game_over = game_over_screen.instantiate()
	add_child(game_over)
