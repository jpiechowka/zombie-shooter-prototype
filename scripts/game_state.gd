extends Node


var game_state: Dictionary = {}


# Called when the node enters the scene tree for the first time
func _ready():
	# First load saved game state
	var loaded_game_state = SaverLoader.load_game()
	if loaded_game_state == null:
		print_debug("Loaded game state is null indicating that save file has not been created yet")
		var new_game_state: Dictionary = init_new_game_state()
		
		# Save newly initialized game state
		SaverLoader.save_game(new_game_state)
	else:
		print_debug("Successfully loaded game state")
		game_state = loaded_game_state


func init_new_game_state() -> Dictionary:
	print_debug("Initializing new game state")
	
	# TODO: initialization
	var new_game_state = {
		"game_start_time_epoch" : OS.get_unix_time()
	}
	
	return new_game_state 
