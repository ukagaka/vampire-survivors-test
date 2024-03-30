extends Node

@export var max_speed: int = 40
@export var acceleration: float = 5

var velocity = Vector2.ZERO

func accelerate_to_player():
	var owner_node2d = owner as Node2D
	if owner_node2d == null:
		return
		
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var direction = (player.global_position - owner_node2d.global_position).normalized()
	accelerate_in_direction(direction)
	
	
	
func accelerate_in_direction(direction: Vector2):
	var desired_velocity = direction * max_speed
	velocity = velocity.lerp(desired_velocity, 1 - exp(-acceleration * get_process_delta_time()))

func decelerate():
	accelerate_in_direction(Vector2.ZERO)


func move(character_body: CharacterBody2D):
	character_body.velocity = velocity
	character_body.move_and_slide()
	velocity = character_body.velocity
