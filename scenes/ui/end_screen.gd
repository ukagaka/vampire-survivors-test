extends CanvasLayer


func _ready():
	get_tree().paused = true
	$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/RestartButton.pressed.connect(on_restart_button_pressed)
	$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/QuitButton.pressed.connect(on_quit_button_pressed)

func set_defeat():
	$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/TitleLabel.text = "Defeat"
	$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/DescriptionLabel.text = "You lost!"

func on_restart_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")
	
func on_quit_button_pressed():
	get_tree().quit()
