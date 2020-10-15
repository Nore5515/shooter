extends Node2D


var speed = 13
var dest
var passedDest = false

var ACTIVE = false

func _process(_delta):
	self.translate(transform.x * speed)
	
	if self.position.distance_to(dest) < 5:
		ACTIVE = true
		if passedDest == false:
			passedDest = true
	
	# Initially, you're just travelling towards target...
	else:
		# As you're travelling BEFORE you hit target, ur inactive
		ACTIVE = false
		if passedDest:
			# However, once you pass your dest, it's open season!
			ACTIVE = true


func _on_Bullet_body_entered(body):
	if body.is_in_group("target"):
		if ACTIVE:
			if body.strikeByBullet():
				queue_free()
	elif body.is_in_group("obstacle"):
		queue_free()
	elif body.is_in_group("tilemap"):
		queue_free()

