extends Camera2D

var target_position = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	acquire_target()
	global_position = global_position.lerp(target_position, 1.0 - delta * 20)
	
func acquire_target():
	var playerNodes = get_tree().get_nodes_in_group("player")
	if playerNodes.size() > 0:
		var player = playerNodes[0] as Node2D
		target_position = player.global_position
