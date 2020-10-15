extends Label


var start
var stopped = false


export (bool) var stopwatchMode = false

export (bool) var targetLevel = false

func _ready():
	if !stopwatchMode:
		$Stopwatch.start()
	else:
		start = OS.get_ticks_usec()



func _process(_delta):
	
	
	
	if !stopped:
		if !stopwatchMode:
			text = String(stepify($Stopwatch.time_left, 0.01))
		else:
			text = String(stepify((OS.get_ticks_usec() - start) / 1e+6, 0.01))

		if get_tree().get_nodes_in_group("target").size() <= 0 && targetLevel == true:
			stopped = true
			get_tree().get_nodes_in_group("player")[0].die()
			$Stopwatch.stop()


func _on_Stopwatch_timeout():
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")
