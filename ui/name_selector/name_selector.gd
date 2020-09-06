extends Control

onready var selector = $selector
onready var chars = [
	$first_char,
	$second_char,
	$third_char
]
var index = 0
var positions = [ -2, 14, 30 ]

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
		if index == chars.size() - 1:
			index = 0
		else:
			index += 1
	elif Input.is_action_just_pressed("ui_left"):
		if index == 0:
			index = chars.size() - 1
		else:
			index -= 1
	selector.rect_position.x = positions[index]
	
	if Input.is_action_just_pressed("ui_up"):
		up_ascii()
	if Input.is_action_just_pressed("ui_down"):
		down_ascii()
		
func up_ascii():
	var ascii = chars[index].text.to_ascii()
	var current_ascii = ascii[0]
	ascii[0] = current_ascii + 1
	if(ascii[0] > 90):
		ascii[0] = 65
	chars[index].text = ascii.get_string_from_ascii()

func down_ascii():
	var ascii = chars[index].text.to_ascii()
	var current_ascii = ascii[0]
	ascii[0] = current_ascii - 1
	if(ascii[0] < 65):
		ascii[0] = 90
	chars[index].text = ascii.get_string_from_ascii()

func get_name():
	var input = PoolStringArray([])
	for ch in chars:
		input.append(str(ch.text))
	return input.join("")
