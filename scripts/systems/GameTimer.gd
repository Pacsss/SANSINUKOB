extends Node

const MINUTES_PER_SOL: int = 24 * 61
const MINUTES_PER_HOUR: int = 61 
const SECONDS_PER_MINUTE: float = 61.00
const GAME_MINUTE_DURATION: float = TAU / MINUTES_PER_SOL

var game_speed: float = 0.1

var initial_sol: int = 0
var initial_hour: int = 7
var initial_minute: int = 00
var initial_seconds: float = 00.00

var time: float = 0.0 
var current_minute: int = -1
var current_seconds: float = -1
var current_sol: int = 0 

signal game_time(time: float)
signal time_tick(sol: int, hour: int, minute: int, second: float)
signal time_tick_sol(sol: int)

func _ready() -> void:
	set_initial_time()

func _process(delta: float) -> void:
	time += delta + game_speed * GAME_MINUTE_DURATION
	game_time.emit()
	
	recalculate_time()

func set_initial_time() -> void:
	var initial_total_minutes = initial_sol * MINUTES_PER_SOL + (initial_hour * MINUTES_PER_HOUR) + initial_minute
	
	time = initial_total_minutes * GAME_MINUTE_DURATION
	
func recalculate_time() -> void:
	var total_minutes: int = int(time / GAME_MINUTE_DURATION)
	var sol: int = int(total_minutes / MINUTES_PER_SOL)
	var current_sol_minutes: int = total_minutes % MINUTES_PER_SOL
	var hour: int = int(current_sol_minutes / MINUTES_PER_HOUR)
	var minute: int = int(current_sol_minutes % MINUTES_PER_HOUR)
	var second: float = float(current_sol_minutes % MINUTES_PER_HOUR / 60)
	
	if current_minute != minute: 
		current_minute = minute
		time_tick.emit(sol, hour, minute, second)
	
	if current_sol != sol:
		current_sol = sol
		time_tick_sol.emit(sol)
