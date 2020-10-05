extends Node2D


var speed = 13


func _process(_delta):
	self.translate(transform.x * speed)


func _on_Bullet_body_entered(body):
	if body.is_in_group("target"):
		body.strikeByBullet()
		queue_free()

