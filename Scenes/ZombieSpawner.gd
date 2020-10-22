extends Node2D



export (bool) var isBigBrain = false


func _on_Timer_timeout():
	print ("zombie")
	var zombieInstance = load("res://Scenes/Zombie.tscn").instance()
	zombieInstance.global_position = global_position
	zombieInstance.crateDropOdds = 15
	zombieInstance.bigbrainZombieMoving = isBigBrain
	get_parent().add_child(zombieInstance)
	get_node("Timer").wait_time = rand_range(0.1, 5.0)
