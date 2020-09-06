extends KinematicBody2D
class_name Player

export (float) var speed = 1.3
export (Resource) var weapon = load("weapons/default/default.tscn")
export (int) var lives = 2
export (int) var bombs = 3

var velocity = Vector2()
var score = 0
var hiscore = 0
var hud
var iframe = false
onready var iframe_timer = $iframe_timer
onready var sprite = $sprite
var explosion_resource = preload("res://objects/explosion/explosion.tscn")
var collision_info
var game_over_screen = preload("res://ui/game_over/game_over.tscn")
var level
var extra_lives = 0

func _ready():
	level = get_tree().get_root().get_node("level")
	hud = get_parent().get_node("hud")
	update_weapon()

func _physics_process(delta):
	get_input()
	collision_info = move_and_collide(velocity)
	if collision_info:
		if collision_info.collider.has_method("kill"):
			collision_info.collider.kill()
			kill()
		if collision_info.collider.has_method("reward"):
			collision_info.collider.reward(self)
	
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right") && position.x < ProjectSettings.get("display/window/size/width") - 9:
		velocity.x += 1
	if Input.is_action_pressed("ui_left") && position.x > 10:
		velocity.x -= 1
	if Input.is_action_pressed("ui_up") && position.y > 7:
		velocity.y -= 1
	if Input.is_action_pressed("ui_down") && position.y < ProjectSettings.get("display/window/size/height") - 16:
		velocity.y += 1
	velocity = velocity.normalized() * speed
	
	if Input.is_action_pressed("player_shoot"):
		shoot()
	elif Input.is_action_just_pressed("player_special"):
		special()
		
	if Input.is_key_pressed(KEY_1):
		weapon = load("weapons/default/default.tscn")
		update_weapon()
	if Input.is_key_pressed(KEY_2):
		weapon = load("weapons/double/double.tscn")
		update_weapon()
	if Input.is_key_pressed(KEY_3):
		weapon = load("weapons/laser/laser.tscn")
		update_weapon()
				
func shoot():
	if weapon.has_method("shoot"):
		weapon.shoot()

func special():
	if bombs <= 0:
		return
	bombs -= 1
	for node in get_tree().get_nodes_in_group("Enemies"):
		if node.has_method("kill"):
			node.kill(true)
		else:
			node.queue_free()

func update_weapon():
	if weapon.get_class() != "PackedScene":
		weapon.queue_free()
	weapon = weapon.instance()
	weapon.player = self
	add_child(weapon)
	
func increase_score(points):
	score += points
	if score / 10000 >= 1 + extra_lives:
		lives += 1
		extra_lives += 1
	hud.update_labels()

func kill(end_game: bool = false):
	if !iframe:
		lives -= 1
		hud.update_labels()
		iframe = true
		var explosion = explosion_resource.instance()
		explosion.position = position
		level.add_child(explosion)
		position = Vector2(80, 123)
		sprite.play("iframe")
		iframe_timer.start()
		if lives < 0 || end_game:
			score += bombs * 1000
			score += lives * 2000
			if hiscore == 0:
				hiscore = score
			elif score > hiscore:
				hiscore = score
			var game_over = game_over_screen.instance()
			game_over.score = score
			game_over.hiscore = hiscore
			level.queue_free()
			get_tree().get_root().add_child(game_over)
		
func _on_iframe_timer_timeout():
	iframe = false
	sprite.frame = 0
	sprite.stop()
