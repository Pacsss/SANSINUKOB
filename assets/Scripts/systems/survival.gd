extends Node
# Survival stats
var health: float = 100.0 
var thirst: float = 100.0
var hunger: float = 100.0
var stamina: float = 100.0
var oxygen: float = 100.0

# Status conditions
var active_conditions = []

# Environmental factors
var temperature: float = 20.0
var radiation: float = 0.0
var visibility: float = 100.0

signal stat_changed(stat, value)
signal condition_added(condition)
signal condition_removed(condition)

func _process(delta):
	if GameManager.current_state == GameManager.GAME_STATE.PLAYING:
		update_survival_stats(delta)

func update_survival_stats(delta):
	# Basic decay
	thirst = max(0, thirst - 0.2 * delta)
	hunger = max(0, hunger - 0.1 * delta)
	oxygen = max(0, oxygen - 0.3 * delta)
	
	# Environmental effects
	apply_environmental_effects(delta)
	
	# Condition effects
	apply_condition_effects(delta)
	
	# Emit signals for UI updates
	emit_signal("stat_changed", "thirst", thirst)
	emit_signal("stat_changed", "hunger", hunger)
	emit_signal("stat_changed", "oxygen", oxygen)

func set_health(value):
	health = clamp(value, 0, 100)
	emit_signal("stat_changed", "health", health)
	if health <= 0:
		GameManager.current_state = GameManager.GAME_STATE.GAME_OVER

func apply_environmental_effects(delta):
	# Temperature effects
	if temperature < -10:
		add_condition("hypothermia", 0.1 * abs(temperature + 10) * delta)
	elif temperature > 40:
		add_condition("heat_stroke", 0.1 * (temperature - 40) * delta)
	
	# Radiation effects
	if radiation > 1:
		add_condition("radiation_poisoning", radiation * 0.05 * delta)

func add_condition(condition_name, severity = 1.0):
	for condition in active_conditions:
		if condition.name == condition_name:
			condition.severity = min(condition.severity + severity, 1.0)
			return
	
	var new_condition = {
		"name": condition_name,
		"severity": severity,
		"duration": 0.0
	}
	active_conditions.append(new_condition)
	emit_signal("condition_added", new_condition)

func apply_condition_effects(delta):
	for condition in active_conditions:
		condition.duration += delta
		match condition.name:
			"hypothermia":
				health -= 0.5 * condition.severity * delta
			"heat_stroke":
				health -= 0.3 * condition.severity * delta
				thirst -= 0.5 * condition.severity * delta
			"radiation_poisoning":
				health -= 0.8 * condition.severity * delta
			"starvation":
				health -= 0.2 * condition.severity * delta
			"dehydration":
				health -= 0.4 * condition.severity * delta
			"depression":
				stamina -= 0.3 * condition.severity * delta
