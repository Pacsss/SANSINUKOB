extends Node

# Coeficients (slopes) 
const air_coef: Array = [-25.31268178, 14.06205036]
const hmd_coef: Array = [6.20372511, 4.15439595]
const tmp_coef: Array = [-19.33368572, -22.917459]
const prs_coef: Array = [8.13707233, 2.56892306]
const rds_coef: Array = [0.00010996, -0.00295156]
const wnd_coef: Array = [-2.12350186, -0.54961578] 

# Bias
const air_bs: float = 252.63355499380836
const hmd_bs: float  = 5.49349334959648
const tmp_bs: float = 223.70034672665818
const prs_bs: float = 738.8419459881621
const rds_bs: float = 0.0019775965326058907
const wnd_bs: float = 3.315147976542606	

# Total Seconds of a 1 Sol in Mars
const mars_sol_sec: int = 88775

# Getting In Game Time
func _ready() -> void:
	GameTimer.time_tick.connect(environment)
	if GameTimer.time_tick.is_connected(environment):
		print("The signal is connected to the method.")
	else:
		print("The signal is NOT connected to the method.")

# Computation for Environmental Status
# y = (x1c1 + x2c2) * b 

# Computation for Environmental Status
func environment(sol: int, hour: int, minute: int) -> void:
	var time_sin = sin(2 * (3.14 * (hour * 3600 + minute * 60 ) / mars_sol_sec))
	var time_cos = cos(2 * (3.14 * (hour * 3600 + minute * 60 ) / mars_sol_sec))
	# print(time_sin, " ", time_cos)
	
	var air_tmp = float (time_sin * air_coef[0] + time_cos * air_coef[1]) + air_bs
	var humidity = float (time_sin * hmd_coef[0] + time_cos * hmd_coef[1]) + hmd_bs
	var temperature = float (time_sin * tmp_coef[0] + time_cos * tmp_coef[1]) + tmp_bs
	var pressure = float (time_sin * prs_coef[0] + time_cos * prs_coef[1]) + prs_bs
	var rds = float (time_sin * rds_coef[0] + time_cos * rds_coef[1]) + rds_bs
	var wind = float (time_sin * wnd_coef[0] + time_cos * wnd_coef[1]) + wnd_bs
	print(air_tmp, " ", humidity, " ", temperature, " ", pressure, " ", rds, " ", wind)
	
