extends Node

export (Array, PackedScene) var waves

var rng = RandomNumberGenerator.new()
var passed_waves = 0
var wave 
var level

func _ready():
	level = get_tree().get_root().get_node("level")
	rng.randomize()
	next_wave()

func next_wave():
	wave = waves[rng.randi_range(0, waves.size() - 1)].instance()
	wave.level = self
	level.call_deferred("add_child", wave)
	passed_waves += 1
