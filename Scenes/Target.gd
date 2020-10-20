extends KinematicBody2D



export (int) var HP = 1

export (bool) var moving = false
export (int) var speed = 1

var cashRewards = 0

func _ready():
	if HP == 1:
		cashRewards = 1
	elif HP == 3:
		cashRewards = 2
	elif HP == 6:
		cashRewards = 3
	else:
		print ("WHAT", cashRewards)


# Return TRUE if the bullet should kill itself.
#	This should happen whenever it ticks HP down.
# Return FALSE if the bullet should pass through, i.e. it is dying.
#	If it's not ticking HP, do this.
func strikeByBullet():
	if HP > 0:
		$HitSound.stop()
		$HitSound.play()
	
		HP -= 1
		if HP <= 0:
			$target.visible = false
		return true
	return false


func _on_HitSound_finished():
	if HP <= 0:
		queue_free()
		get_node("/root/Global").cash += cashRewards


func _process(delta):
	if moving:
		self.translate(transform.x * speed)
