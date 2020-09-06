extends Node2D

export (Resource) var spawn_type
export (int) var maximum_spawns
export (float) var spawn_interval = 2

var spawn_timer = Timer.new()
var spawns = 0
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	spawn_timer.wait_time = spawn_interval
	spawn_timer.one_shot = true
	add_child(spawn_timer)

func _process(delta):
	if spawn_timer.is_stopped() && (maximum_spawns < 0 || spawns < maximum_spawns):
		var spawn = spawn_type.instance();
		spawn.position = position
		spawn.position.x = rng.randf_range(16, ProjectSettings.get("display/window/size/width") - 16)
		get_parent().add_child(spawn)
		spawns += 1
		spawn_timer.start()
