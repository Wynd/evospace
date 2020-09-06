extends "../weapon.gd"

func shoot():
	if !shoot_timer.is_stopped():
		return
	var bullet1 = bullet_type.instance()
	bullet1.position = player.position
	bullet1.position.y -= 3
	bullet1.position.x -= 7.5
	bullet1.velocity.y -= bullet_speed
	get_tree().get_root().add_child(bullet1)

	var bullet2 = bullet_type.instance()
	bullet2.position = player.position
	bullet2.position.y -= 3
	bullet2.position.x += 7.5
	bullet2.velocity.y -= bullet_speed
	get_tree().get_root().add_child(bullet2)

	shoot_timer.start()
