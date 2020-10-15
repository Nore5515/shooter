extends Node2D



func _process(delta):
	if get_tree().get_nodes_in_group("zombie").size() <= 0:
		$CanvasLayer/finalTime.visible = true
		$CanvasLayer/finalTime.text = "FINAL TIME: " + \
			String(stepify((OS.get_ticks_usec() - $CanvasLayer/TimerCount.start) / 1e+6, 0.01))


func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")
