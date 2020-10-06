extends Node2D


var speed = 13


func _process(_delta):
	self.translate(transform.x * speed)


func _on_Bullet_body_entered(body):
	if body.is_in_group("target"):
		if body.strikeByBullet():
			queue_free()
	elif body.is_in_group("obstacle"):
		queue_free()
	elif body.is_in_group("tilemap"):
		queue_free()

