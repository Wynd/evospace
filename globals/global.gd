extends Node2D

var game_state = {}

func _ready():
	load_game()

func save_game():
	var save_file = File.new()
	save_file.open("user://savegame.dat", File.WRITE)
	save_file.store_line(to_json(game_state))
	save_file.close()

func load_game():
	var save_file = File.new()
	if not save_file.file_exists("user://savegame.dat"):
		return # Error! We don't have a save to load.

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	save_file.open("user://savegame.dat", File.READ)
	while save_file.get_position() < save_file.get_len():
		# Get the saved dictionary from the next line in the save file
		var node_data = parse_json(save_file.get_line())
		
		for key in node_data.keys():
			game_state[key] = node_data[key]

	save_file.close()

func get_hiscores():
	if !game_state.has("hiscores"):
		return []
	game_state["hiscores"].sort_custom(self, "score_sort")
	game_state["hiscores"].invert()
	return global.game_state["hiscores"]

func get_highest_score():
	if !game_state.has("hiscores"):
		return ["", 0]
	game_state["hiscores"].sort_custom(self, "score_sort")
	game_state["hiscores"].invert()
	return game_state["hiscores"][0]

func score_sort(a, b):
	if a[1] < b[1]:
		return true
	return false
