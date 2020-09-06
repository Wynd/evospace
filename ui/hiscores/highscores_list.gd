extends Control

var main_menu_screen = load("ui/main_menu/main_menu.tscn")

func _ready():
	main_menu_screen = main_menu_screen.instance()
	var highscores = global.get_hiscores()
	for node in get_children():
		node.hide()
	var index = 0
	var scores = []
	for i in range(0, highscores.size()):
		get_child(i).show()
		var key = highscores[i][0]
		var score = highscores[i][1]
		scores.append(str(key, " - ", score))
		get_child(i).get_node("name").text = str(key, " - ", score)
	
func _process(delta):
	if Input.is_action_just_pressed("player_special"):
		get_node("../../").queue_free()
		get_tree().get_root().add_child(main_menu_screen)
