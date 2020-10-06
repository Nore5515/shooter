extends Label


var done = false


func _process(delta):
	
	if !done:
		if get_tree().get_nodes_in_group("tut1").size() <= 0:
			done = true
			visible = true
			
			
			for x in range(6):
				get_parent().get_node("Tilemap").set_cellv(Vector2(55+x, 44), 1)
				get_parent().get_node("Tilemap").set_cellv(Vector2(55+x, 45), 1)
				get_parent().get_node("Tilemap").set_cellv(Vector2(55+x, 46), 1)
