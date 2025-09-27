extends Node

# Game states
enum GAME_STATE { MENU, PLAYING, PAUSED, GAME_OVER }
var current_state = GAME_STATE.MENU

# Player data
var player_role = null
var player_data = {
	"health": 100.0,
	"thirst": 100.0,
	"hunger": 100.0,
	"stamina": 100.0,
	"oxygen": 100.0,
	"inventory": [],
	"skills": {},
	"conditions": [],
	"discoveries": [],
	"story_progress": 0
}

# Character roles
enum ROLES { CIVILIAN, ENGINEER, DOCTOR, ENVIRONMENTALIST, CAPTAIN }

# Skill system
var skill_trees = {
	ROLES.ENGINEER: ["Tool Repair", "Advanced Machinery", "Blueprint Reading", "Complex Construction", "Resource Optimization"],
	ROLES.DOCTOR: ["Basic Wound Care", "Critical Injury Treatment", "Antibiotic Crafting", "Advanced Medical Procedures", "Master Healing"],
	ROLES.ENVIRONMENTALIST: ["Plant Identification", "Soil Testing", "Agricultural Efficiency", "Toxin Detection", "Advanced Environmental Mastery"],
	ROLES.CAPTAIN: ["Basic Facility Access", "Remote Rover Control", "Rough Terrain Navigation", "Hazardous Area Exploration", "Master Piloting"]
}

# Weather system
var weather_conditions = {
	"clear": {"temp_variation": 20, "visibility": 100},
	"dust_storm": {"temp_variation": -30, "visibility": 30, "damage_rate": 0.5},
	"solar_flare": {"radiation": 2.0, "visibility": 80}
}

func _ready():
	load_game_data()
	setup_input_map()

func setup_input_map():
	# Input actions
	InputMap.add_action("left")
	InputMap.add_action("right")
	InputMap.add_action("jump")
	InputMap.add_action("interact")
	InputMap.add_action("craft")
	InputMap.add_action("inventory")
	InputMap.add_action("pause")

func load_game_data():
	# Load saved game data
	pass

func save_game():
	# Save game progress
	pass

func change_game_state(new_state):
	current_state = new_state
	get_tree().paused = (new_state == GAME_STATE.PAUSED)
	
