extends Control

onready var score_label = $score
onready var hiscore_label = $hiscore
onready var name_selector = $name_selector

var main_menu_screen = load("ui/main_menu/main_menu.tscn")

var score = 0
var hiscore = 0
var hiscores = []
var global

func _ready():
	global = get_node("/root/global")
	
	var hiscore_display = hiscore
	var highest_score = global.get_highest_score()[1]
	
	if highest_score > hiscore:
		hiscore_display = highest_score
	
	score_label.text = str("Score: ", score)
	hiscore_label.text = str("High Score: ", hiscore_display)
	hiscores = global.get_hiscores()

func _process(delta):
	if Input.is_action_just_pressed("player_shoot"):
		hiscores.push_back([name_selector.get_name(), hiscore])
		global.game_state["hiscores"] = hiscores
		global.save_game()
		go_to_main_menu()
	elif Input.is_action_just_pressed("player_special"):
		go_to_main_menu()

func go_to_main_menu():
	var screen = main_menu_screen.instance()
	queue_free()
	get_tree().get_root().add_child(screen)
