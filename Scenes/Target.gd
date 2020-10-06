extends KinematicBody2D



var HP = 3



func strikeByBullet():
	HP -= 1
	if HP <= 0:
		queue_free()
