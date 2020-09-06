extends Control

onready var score_label: Label = $layer/score_label
onready var bombs_label: Label = $layer/bombs_label
onready var lives_label: Label = $layer/lives_label
onready var timer_label: Label = $layer/timer_label
onready var timer: Timer = $layer/timer_label/round_timer

var player

func _ready():
	player = get_parent().get_node("player")
	update_labels()

func _process(delta):
	timer_label.text = str("T: ", timer.time_left).pad_decimals(0)

func update_labels():
	score_label.text = str("Score: ", player.score).pad_zeros(8)
	lives_label.text = str(player.lives)
	bombs_label.text = str(player.bombs)

func _on_round_timer_timeout():
	player.kill(true)
