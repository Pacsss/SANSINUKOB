extends Control

@onready var sol_label: Label = $DayPanel/MarginContainer/SolLabel
@onready var time_label: Label = $TimePanel/MarginContainer/TimeLabel

@export var normal_speed = 0.1

func _ready() -> void:
	GameTimer.time_tick.connect(on_time_tick)

func on_time_tick(sol: int, hour: int, minute: int) -> void:
	sol_label.text = "Sol " + str(sol)
	time_label.text = "%02d:%02d" % [hour, minute]
	
	
