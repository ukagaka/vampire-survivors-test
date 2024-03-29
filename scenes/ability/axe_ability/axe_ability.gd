extends Node2D

const MAX_RADIUS = 100

@onready var hitbox_component = $HitboxComponent

var base_rotation = Vector2.RIGHT

func _ready():
	
	base_rotation = Vector2.RIGHT.rotated(randf_range(0, TAU))
	
	var tween = create_tween()
	tween.tween_method(tween_method, 0.0, 2.0, 3)
	tween.tween_callback(queue_free)


func tween_method(rotations: float):
	var percent = rotations /2
	var current_radius = percent * MAX_RADIUS
	var current_direction = base_rotation.rotated(rotations * TAU)
	
	var root_position = Vector2.ZERO
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return
		
	global_position = player.global_position + (current_direction * current_radius)
