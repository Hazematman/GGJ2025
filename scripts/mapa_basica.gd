extends Node3D

@export var editor: Node = null

const game_over_screen = preload("res://scenes/game_over.tscn")
const gana_screen = preload("res://scenes/gana.tscn")
@export var next: PackedScene = preload("res://scenes/main_menu.tscn")

var menu = false
var done = false
var GO = game_over_screen.instantiate()

signal mata
signal gana

func _on_gana() -> void:
	print("GANADOR!")
	var gana_node = gana_screen.instantiate()
	gana_node.next = next
	add_child(gana_node)
	menu = true
	done = true

func _on_mata() -> void:
	print("MATA")
	if editor != null:
		get_parent().add_child(editor)
		get_parent().call_deferred("remove_child", self)
		queue_free()
	else:
		var game_over = game_over_screen.instantiate()
		add_child(game_over)

func _input(ev):
	if done:
		return
	if Input.is_action_just_pressed("Menu"):
		if menu == false:
			menu = true
			add_child(GO)
		else:
			menu = false
			remove_child(GO)
