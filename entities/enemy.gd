extends KinematicBody2D
class_name Enemy

export (float) var health = 1.0
export (int) var points = 1
export (float) var powerup_drop_chance = 0.1
export (Resource) var explosion = load("objects/explosion/explosion.tscn")

var velocity = Vector2()
var rng = RandomNumberGenerator.new()
var player
var powerups = [
	preload("res://entities/powerups/double/double.tscn"),
	preload("res://entities/powerups/laser/laser.tscn")
]
var collision_info
var level

func _ready():
	player = get_tree().get_root().get_node("level/player")
	rng.randomize()
	explosion = explosion.instance()
	level = get_parent()

func _physics_process(delta):
	if collision_info:
		var collision_point = collision_info.position
		if(collision_info.collider is Player):
			(collision_info.collider as Player).kill()
			explosion.position = position
			level.add_child(explosion)
			queue_free()

func damage(damage: float):
	health -= damage
	if health <= 0:
		kill(true)
			
func kill(get_points: bool = false):
	if get_points:
		player.increase_score(points)
	explosion.position = position
	level.add_child(explosion)
	# Worth noting: meteorites are not spawned as part of the wave but instead as part of the root element, which means their "level" won't have the 
	# kill_enemy method, which in turn avoids waves being finished early by destroying meteorites instead of the wave spawns
	if level.has_method("kill_enemy"): 
		level.kill_enemy()
	if rng.randf() < powerup_drop_chance:
		var powerup = powerups[rng.randi_range(0, powerups.size() - 1)].instance()
		powerup.position = position
		level.add_child(powerup)
	queue_free()
	
func _on_visiblity_notifier_screen_exited():
	queue_free()
