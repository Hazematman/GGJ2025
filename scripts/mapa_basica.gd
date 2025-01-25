extends Node3D

@export var editor: Node = null

const game_over_screen = preload("res://scenes/game_over.tscn")

signal mata
signal gana

func _on_gana() -> void:
	print("GANADOR!")
	add_child(game_over_screen.instantiate())

func _on_mata() -> void:
	print("MATA")
	if editor != null:
		get_parent().add_child(editor)
		get_parent().call_deferred("remove_child", self)
		queue_free()
	else:
		var game_over = game_over_screen.instantiate()
		add_child(game_over)
