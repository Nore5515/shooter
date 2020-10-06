extends Label


var done = false


func _process(delta):
	
	if !done:
		if get_tree().get_nodes_in_group("tut2").size() <= 0:
			done = true
			visible = true
