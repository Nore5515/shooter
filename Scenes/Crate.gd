extends Area2D



var ammoAmount = 24



func _on_Crate_body_entered(body):
	if body.is_in_group("player"):
		body.pistolAmmoReserves += ammoAmount
		queue_free()
