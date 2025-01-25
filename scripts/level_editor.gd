extends Control

@onready var grid = $GridContainer

var opcíones = [
	"Aire",
	"Tierra",
	"Pincho",
]

var opcíones_node = {
	"Aire": null,
	"Tierra": preload("res://scenes/tierra.tscn"),
	"Pincho": preload("res://scenes/pincho.tscn"),
}

var mapa_basica: PackedScene = preload("res://scenes/mapa_basica.tscn")

var columns: int = 0
var rows: int  = 0

var nivel = null

func crear_lista_de_objectos() -> Control:
	var opcíon_buton = OptionButton.new()
	for opcíon in opcíones:
		opcíon_buton.add_item(opcíon[0])
	return opcíon_buton

func _on_cambia_tamaño() -> void:
	columns = int($Container/LineEdit_X_dim.text)
	rows = int($Container/LineEdit_Y_dim.text)
	print("Size ", columns, " ", rows)
	
	for child in $GridContainer.get_children():
		$GridContainer.remove_child(child)
	
	grid.columns = columns
	
	for elem in range(columns * rows):
		var opción = crear_lista_de_objectos()
		grid.add_child(opción)

func prueba_nivel() -> void:
	var nuevo_nivel = mapa_basica.instantiate()
	
	for elem in range(columns * rows):
		var x = elem % rows
		var y = elem / rows
		var opcíon: OptionButton = grid.get_child(elem)
		var node_nombre = opcíones[opcíon.selected]
		var node_nuevo: PackedScene = opcíones_node[node_nombre]
		if node_nuevo != null:
			var node: Node3D = node_nuevo.instantiate()
			node.position = Vector3(x, 0, y)
			nuevo_nivel.add_child(node)
	
	get_parent().add_child(nuevo_nivel)
	get_parent().remove_child(self)
	
func save_level() -> void:
	var nodes = []
	for elem in range(columns * rows):
		var x = elem % rows
		var y = elem / rows
		var opcíon: OptionButton = grid.get_child(elem)
		var node_nombre = opcíones[opcíon.selected]
		nodes.append(node_nombre)
		
	self.nivel = {
		"columns": columns,
		"rows": rows,
		"nodes": nodes
	}
	
	$FileDialogSave.show()
	
func load_level(path: String) -> void:
	print("Loading ", path)
	var load_file = FileAccess.open(path, FileAccess.READ)
	if load_file == null:
		print("File not found")
		return
	var json_string = load_file.get_as_text()
	var nuevo_nivel = JSON.parse_string(json_string)
	$Container/LineEdit_X_dim.text = str(nuevo_nivel["columns"])
	$Container/LineEdit_Y_dim.text = str(nuevo_nivel["rows"])
	
	_on_cambia_tamaño()
	
	var index = 0
	for child in $GridContainer.get_children():
		child.selected = opcíones.find(nuevo_nivel["nodes"][index])
		index += 1

func _on_prueba_pressed() -> void:
	prueba_nivel()


func _on_guardar_pressed() -> void:
	save_level()


func _on_file_dialog_save_confirmed(path: String) -> void:
	print("Saving ", path)
	
	var save_file = FileAccess.open(path, FileAccess.WRITE)
	var json_string = JSON.stringify(self.nivel)
	save_file.store_line(json_string)
	self.nivel = null

func _on_cargar_pressed() -> void:
	$FileDialogLoad.show()

func _on_file_dialog_load_file_selected(path: String) -> void:
	load_level(path)
