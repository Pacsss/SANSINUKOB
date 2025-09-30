extends Control

@onready var folder: TouchScreenButton = $folder/folder

func _on_pressed() -> void:
	folder.modulate.a = 0.5
	
