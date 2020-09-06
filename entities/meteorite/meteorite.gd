extends "../enemy.gd"

var rotation_speed
var meteorite_size
# Number of textures available, for the sake of simplicity both small and large meteorites have the same number of textures
const TEXTURES = 3

func _ready():
	meteorite_size = rng.randi_range(0, 1)
	velocity.y = rng.randf_range(0.2, 0.5)
	velocity.x = rng.randf_range(-0.02, 0.02)
	var rand_texture = rng.randi_range(1, TEXTURES)
	var meteorite_texture = load(str("res://entities/meteorite/meteor_", ("big" if meteorite_size == 1 else "small") ,"_", rand_texture, ".png"))
	get_node("texture").texture = meteorite_texture
	rotation_speed = rng.randf_range(-2, 2)

func _physics_process(delta):
	rotation += rotation_speed * delta
	collision_info = move_and_collide(velocity)
