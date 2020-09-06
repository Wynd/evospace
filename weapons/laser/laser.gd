extends "../weapon.gd"

func shoot():
	if !shoot_timer.is_stopped():
		return
	var bullet = bullet_type.instance()
	bullet.position = player.position
	bullet.position.y -= 8
	bullet.velocity.y -= bullet_speed
	bullet.damage = 0.2
	get_parent().get_parent().add_child(bullet)
	shoot_timer.start()
