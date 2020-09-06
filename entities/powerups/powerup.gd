extends KinematicBody2D

export (Resource) var weapon

var rng = RandomNumberGenerator.new()
var speed
var velocity = Vector2(0, 0.2)
var dir = 0

func _ready():
	rng.randomize()
	speed = rng.randf_range(0.2, 0.8)
	velocity.x = speed

func _physics_process(delta):
	
	if dir == 0 && position.x > ProjectSettings.get("display/window/size/width") - 8:
		dir = 1
		velocity.x = -speed
	elif dir == 1 && position.x < 8:
		dir = 0
		velocity.x = speed
				
	var collision_info = move_and_collide(velocity)
	if collision_info && collision_info.collider is Player:
		var player = (collision_info.collider as Player)
		reward(player)

func _on_visiblity_notifier_screen_exited():
	queue_free()
	
func reward(player):
	player.weapon = weapon
	player.update_weapon()
	player.increase_score(50)
	queue_free()
