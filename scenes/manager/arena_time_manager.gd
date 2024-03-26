extends Node

@onready var timer = $Timer

func get_time_elapsed():
	return timer.wait_time - timer.time_left
