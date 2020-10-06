extends Label


var start
var stopped = false



func _ready():
	start = OS.get_ticks_usec()



func _process(_delta):
	
	if !stopped:
		if get_tree().get_nodes_in_group("target").size() <= 0:
			stopped = true
		
		text = String(stepify((OS.get_ticks_usec() - start) / 1e+6, 0.01))
