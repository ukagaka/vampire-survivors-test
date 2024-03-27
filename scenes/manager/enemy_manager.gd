extends Node

const SPAWN_PADIUS = 375

@export var basic_enemy_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(on_timer_timeout)

func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return

	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player.global_position + (random_direction * SPAWN_PADIUS)
	
	var enemy = basic_enemy_scene.instantiate() as Node2D
	
	var entities_layes = get_tree().get_first_node_in_group("entities_layer")
	entities_layes.add_child(enemy)
	enemy.global_position = spawn_position
