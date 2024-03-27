extends Node

@export var end_screen_scene: PackedScene

func _ready():
	$Entities/Player.health_component.died.connect(on_player_died)
	
func on_player_died():
	#注意下面顺序，先实例化对象，加载对象，然后才能调加载对象内的方法
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
	end_screen_instance.set_defeat()
