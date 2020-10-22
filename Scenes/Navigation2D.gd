extends Navigation2D


var nearestGate

func _ready():
	
	pathfindZombies()



func pathfindZombies():
	for zombie in get_tree().get_nodes_in_group("zombie"):
		
		nearestGate = null
		
		
		# HELPPPP
		if zombie.distance_to(zombie.navDest) < 5:
			zombie.lastNav = zombie.navDest
		
		for gate in get_tree().get_nodes_in_group("gatepoint"):
			if gate.global_position == zombie.lastNav:
				pass
			else:
				if nearestGate == null:
					nearestGate = gate
				else:
					var nearDistance = nearestGate.global_position.distance_to(zombie.global_position)
					var newDistance = gate.global_position.distance_to(zombie.global_position)
					if newDistance < nearDistance:
						nearestGate = gate
		
		zombie.navDest = nearestGate.global_position


func _on_UpdateTimer_timeout():
	pathfindZombies()
