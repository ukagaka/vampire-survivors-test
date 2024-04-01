extends CanvasLayer

signal transitioned_halfway

#按照教程使用该信号后，操作后会出现卡屏，必须按空格，所以这里注释掉
#var skip_emit = false

func transition():
	$AnimationPlayer.play("default")
	await transitioned_halfway
	#skip_emit = true
	$AnimationPlayer.play_backwards("default")


func transition_to_scene(scene_path: String):
	transition()
	await transitioned_halfway
	get_tree().change_scene_to_file(scene_path)


func emit_transitioned_halfway():
	#if skip_emit:
		#skip_emit = false
		#return
	transitioned_halfway.emit()
