extends Area2D



func _on_Crate_body_entered(body):
	if body.is_in_group("player"):
		if body.arActive:
			var ammoAmount = 0
			ammoAmount += get_node("/root/Global").arSize
			ammoAmount = ammoAmount * get_node("/root/Global").arAmmoMultiplier
			body.arAmmoReserves += ammoAmount
		elif body.pistolActive:
			var ammoAmount = 0
			ammoAmount += get_node("/root/Global").pistolSize
			ammoAmount = ammoAmount * get_node("/root/Global").pistolAmmoMultiplier
			body.pistolAmmoReserves += ammoAmount
		body.get_node("AmmoPickup").stop()
		body.get_node("AmmoPickup").play()
		queue_free()
