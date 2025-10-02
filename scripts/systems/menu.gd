extends Control
@onready var helmet: TouchScreenButton = $helmet/helmet
@onready var folder: TouchScreenButton = $folder/folder
@onready var book: TouchScreenButton = $book/book
@onready var helmetcanvas: CanvasLayer = $helmetcanvas
@onready var foldercanvas: CanvasLayer = $foldercanvas
@onready var bookcanvas: CanvasLayer = $bookcanvas

func _ready():
	close_all_menus()


func _on_helmet_pressed() -> void:
	close_all_menus()
	helmet.modulate.a = 0.5
	helmetcanvas.visible = true 


func _on_helmet_released() -> void:
	helmet.modulate.a = 1.0


func _on_folder_pressed() -> void:
	close_all_menus()
	folder.modulate.a = 0.5
	foldercanvas.visible = true


func _on_folder_released() -> void:
	folder.modulate.a = 1.0


func _on_book_pressed() -> void:
	close_all_menus()
	book.modulate.a = 0.5
	bookcanvas.visible = true


func _on_book_released() -> void:
	book.modulate.a = 1.0

func _on_close_pressed() -> void:
	close_all_menus()

func close_all_menus():
	helmetcanvas.visible = false
	foldercanvas.visible = false
	bookcanvas.visible = false
