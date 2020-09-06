extends "../enemy.gd"

export (int) var pellett_count = 10
export (int) var pellett_radius = 10
export (float) var pellett_speed = 0.6
export (int) var pellett_rows_per_wave = 3
export (int) var pellet_waves = 3

var shoot_timer = Timer.new()
var phase = -1
var max_phase
var pellett = preload("res://entities/pellett/pellett.tscn")

func _ready():
	shoot_timer.one_shot = true
	shoot_timer.wait_time = 0.5
	add_child(shoot_timer)
	max_phase = pellet_waves * pellett_rows_per_wave
	
func _process(delta):
	if shoot_timer.is_stopped() && phase >= 0 && phase <= max_phase:
		if phase % pellett_rows_per_wave == 0:
			shoot_timer.wait_time = 3.5
		else:
			shoot_timer.wait_time = 0.5
		phase += 1
		var angle_step = 2.0 * PI / pellett_count
		var angle = 0	
		for i in range(0, pellett_count):
			var direction = Vector2(cos(angle), sin(angle))
			var pos = position + direction * pellett_radius		
			var pellett_shot = pellett.instance()
			pellett_shot.position = pos
			angle += angle_step
			pellett_shot.velocity = direction * pellett_speed
			level.add_child(pellett_shot)
		shoot_timer.start()
			
func _physics_process(delta):
	if phase == -1 && position.y < 40:
		velocity.y = 0.8
	elif phase == - 1:
		phase = 1
		velocity = Vector2(0, 0)

	if shoot_timer.is_stopped() && phase >= max_phase - 1:
		velocity.y = 0.8
	collision_info = move_and_collide(velocity)
