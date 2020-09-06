extends Node

export (int) var number_of_enemies = 0

var level
var timer = Timer.new()

func _ready():
	timer.one_shot = true
	timer.wait_time = 5
	add_child(timer)	

func _process(delta):
	if number_of_enemies <= 0 && timer.is_stopped():
		queue_free()
				
func kill_enemy():
	number_of_enemies -= 1
	if number_of_enemies == 0:
		level.next_wave()
		timer.start()
