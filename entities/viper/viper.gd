extends "../enemy.gd"

export (int) var speed = 0.1

var target: Vector2

func _ready():
	target = player.position
	rotation = position.angle_to_point(target) + 1.5707
	
func _physics_process(delta):
	position = position.move_toward(target, delta * speed)
	if position == target:	
		if get_parent().has_method("kill_enemy"):
			get_parent().kill_enemy()
		explosion.position = position
		level.add_child(explosion)
		queue_free()
