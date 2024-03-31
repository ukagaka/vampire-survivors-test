extends CanvasLayer

var options_scene = preload("res://scenes/ui/options_menu.tscn")

func _ready():
	$%PlayButton.pressed.connect(on_play_pressed)
	$%OptionsButton.pressed.connect(on_options_pressed)
	$%QuitButton.pressed.connect(on_quit_pressed)
	
func on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")

func on_options_pressed():
	var options_instance = options_scene.instantiate()
	add_child(options_instance)
	options_instance.back_pressed.connect(on_options_closed.bind(options_instance))
	
func on_quit_pressed():
	get_tree().quit()
	
func on_options_closed(options_instanced: Node):
	options_instanced.queue_free()
