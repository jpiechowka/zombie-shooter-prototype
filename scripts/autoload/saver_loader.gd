extends Node


const save_file_location: String = "user://save.bin"
var os_unique_id: String = OS.get_unique_id()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

func load_game() -> Object:
	print_debug("loading game from: " + save_file_location)
	print_debug("OS unique ID: " + os_unique_id)
	
	var save_game_file: File = File.new()
	
	# First check if save file exists
	if not save_game_file.file_exists(save_file_location):
		print_debug("Save fifle does not exist: " + save_file_location)
		return null
	
	# If file is present open it and decrypt
	if save_game_file.open_encrypted_with_pass(save_file_location, File.READ, os_unique_id):
		print_debug("Error when opening encrypted save file: " + save_file_location)
		return null
	
	var save_data = parse_json(save_game_file.get_as_text())
	print_debug(save_data)  # TODO: delete
	
	save_game_file.close()
	
	return save_data


# TODO: return error when saving
func save_game(game_state: Dictionary) -> void:
	print_debug("saving game to: " + save_file_location)
	print_debug("OS unique ID: " + os_unique_id)
	
	var save_game_file: File = File.new()
	if save_game_file.open_encrypted_with_pass(save_file_location, File.WRITE, os_unique_id):
		print_debug("Error when opening encrypted save file: " + save_file_location)
	
	save_game_file.store_line(to_json(game_state))
	print_debug(to_json(game_state))  # TODO: delete
	
	save_game_file.close()
