extends Control

onready var caret = $caret
var index = 0
var spacing = 16
var start_position = 8
var menu_items = 0
var positions = [ 8, 24 ]

var highscores_screen = load("ui/hiscores/hiscores.tscn")
var game_screen = load("levels/demo.tscn")

func _ready():
	menu_items = get_children().size() - 1
	highscores_screen = highscores_screen.instance()
	game_screen = game_screen.instance()

func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		if index == menu_items - 1:
			index = 0
		else:
			index += 1
		update_caret()
	elif Input.is_action_just_pressed("ui_up"):
		if index == 0:
			index = menu_items - 1
		else:
			index -= 1
		update_caret()
	
	if Input.is_action_just_pressed("player_shoot"):
		var action = str(get_child(index).name)
		if has_method(action):
			call(action)
			Input.action_release("player_shoot")
		else:
			print_debug(action, " is not a valid menu action!")

func update_caret():
	caret.rect_position.y = start_position + (spacing * index)

func start():
	get_node("../../").queue_free()
	get_tree().get_root().add_child(game_screen)

func highscores():
	get_node("../../").queue_free()
	get_tree().get_root().add_child(highscores_screen)

func quit():
	get_tree().quit()
