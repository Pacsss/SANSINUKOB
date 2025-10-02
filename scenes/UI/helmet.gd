extends TouchScreenButton
@onready var helmet: TouchScreenButton = $"."

func _on_pressed() -> void:
	helmet.modulate.a = 0.5


func _on_released() -> void:
	helmet.modulate.a = 1
