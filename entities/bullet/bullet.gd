extends KinematicBody2D

var damage = 1.0
var velocity = Vector2()

func _physics_process(delta):
	var collision_info = move_and_collide(velocity)
	if collision_info:
		var collision_point = collision_info.position
		if(collision_info.collider is Enemy):
			(collision_info.collider as Enemy).damage(damage)
			queue_free()

func _on_visiblity_notifier_screen_exited():
	queue_free()
