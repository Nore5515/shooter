extends Area2D



var ammoAmountPistol = 24
var ammoAmountAR = 60



func _on_Crate_body_entered(body):
	if body.is_in_group("player"):
		if body.arActive:
			body.arAmmoReserves += ammoAmountAR
		elif body.pistolActive:
			body.pistolAmmoReserves += ammoAmountPistol
		body.get_node("AmmoPickup").stop()
		body.get_node("AmmoPickup").play()
		queue_free()
