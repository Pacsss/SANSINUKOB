extends Control
@onready var helmet: TouchScreenButton = $helmet/helmet
@onready var folder: TouchScreenButton = $folder/folder
@onready var book: TouchScreenButton = $book/book
@onready var canvas_layer: CanvasLayer = $CanvasLayer

func _ready():
	canvas_layer.visible = false

func _on_helmet_pressed() -> void:
	helmet.modulate.a = 0.5
	canvas_layer.visible = not canvas_layer.visible

	
func _on_helmet_released() -> void:
	helmet.modulate.a = 1.0

func _on_folder_pressed() -> void:
	folder.modulate.a = 0.5

func _on_folder_released() -> void:
	folder.modulate.a = 1.0

func _on_book_pressed() -> void:
	book.modulate.a = 0.5

func _on_book_released() -> void:
	book.modulate.a = 1.0
