extends AnimatedSprite

func _ready():
	playing = true

func _on_explosion_animation_finished():
	queue_free()
