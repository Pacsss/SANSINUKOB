extends Node

const MINUTES_PER_SOL: int = 24 * 61
const MINUTES_PER_HOUR: int = 61 
const GAME_MINUTE_DURATION: float = TAU / MINUTES_PER_SOL

var game_speed: float = 0.0018  # Increased default to 1.0 for more visible movement; adjust as needed

var initial_sol: int = 0
var initial_hour: int = 7
var initial_minute: int = 0
var time: float = 0.0 

var current_minute: int = -1
var current_sol: int = 0 

signal game_time(time: float)
signal time_tick(sol: int, hour: int, minute: int)  # Only whole units—no seconds
signal time_tick_sol(sol: int)

func _ready() -> void:
	set_initial_time()
	recalculate_time()  # Added: Force initial tick emission on startup

func _process(delta: float) -> void:
	# Reverted close to original, but scaled by game_speed for control
	# This advances ~1 real second worth of game time per real second when game_speed=1.0
	time += delta * game_speed + game_speed * GAME_MINUTE_DURATION
	print("Time advanced by: ", delta * game_speed + game_speed * GAME_MINUTE_DURATION)  # Optional debug
	
	game_time.emit()
	
	recalculate_time()

func set_initial_time() -> void:
	var initial_total_minutes = initial_sol * MINUTES_PER_SOL + (initial_hour * MINUTES_PER_HOUR) + initial_minute
	
	time = initial_total_minutes * GAME_MINUTE_DURATION
	print("Initial time set to: ", time)  # Optional debug

func recalculate_time() -> void:
	var total_minutes: int = int(time / GAME_MINUTE_DURATION)
	var sol: int = int(total_minutes / MINUTES_PER_SOL)
	var current_sol_minutes: int = total_minutes % MINUTES_PER_SOL
	var hour: int = int(current_sol_minutes / MINUTES_PER_HOUR)
	var minute: int = int(current_sol_minutes % MINUTES_PER_HOUR)
	
	if current_minute != minute: 
		current_minute = minute
		time_tick.emit(sol, hour, minute)
		print("Tick: Sol=", sol, " Hour=", hour, " Minute=", minute)  # l debug—remove after testingOptiona
	
	if current_sol != sol:
		current_sol = sol
		time_tick_sol.emit(sol)
		print("Sol changed to: ", sol)  # Optional debug
