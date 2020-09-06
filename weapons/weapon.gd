extends Node2D
class_name Weapon

export (int) var bullet_speed = 2
export (float) var shoot_cooldown = 0.1
export (Resource) var bullet_type = load("entities/bullet/bullet.tscn")

var shoot_timer = Timer.new()
var player

func _ready():
	shoot_timer.wait_time = shoot_cooldown
	shoot_timer.one_shot = true
	add_child(shoot_timer)

func shoot():
	if !shoot_timer.is_stopped():
		return
	var bullet = bullet_type.instance()
	bullet.position = player.position
	bullet.position.y -= 8
	bullet.velocity.y -= bullet_speed
	shoot_timer.start()
	player.level.add_child(bullet)
