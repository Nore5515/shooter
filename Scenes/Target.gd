extends KinematicBody2D



export (int) var HP = 1



func strikeByBullet():
	HP -= 1
	if HP <= 0:
		queue_free()
