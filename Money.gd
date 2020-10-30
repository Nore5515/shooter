extends Area2D





func _on_Money_body_entered(body):
	if body.is_in_group("player"):
		get_node("/root/Global").cash += 10
		queue_free()
