extends KinematicBody2D


var playerLoc
var speed = 30

var maxHP = 100
var HP = 100
var legsHP = 20
var legsBroken = false

export (float) var crateDropOdds = 0


func _process(delta):
	$ProgressBar.value = HP
	var playerPos = get_tree().get_nodes_in_group("player")[0].global_position

	var collision = move_and_collide(global_position.direction_to(playerPos) * speed * delta)
	#if collision:
		#print (collision.collider.name)

	if legsHP <= 0 && legsBroken == false:
		$Legsnap.play()
		legsBroken = true
		speed = 5
	
	if HP <= 0:
		if crateDropOdds > 0:
			if rand_range(0, 100) < crateDropOdds:
				var crateInstance = load("res://Scenes/Crate.tscn").instance()
				crateInstance.global_position = global_position
				get_parent().add_child(crateInstance)
		var soundInstance = load("res://Scenes/Deathsound.tscn").instance()
		get_parent().add_child(soundInstance)
		queue_free()

func _on_Head_area_entered(area):
	if area.is_in_group("bullet"):
		if area.ACTIVE:
			HP -= 65
			area.queue_free()
			$MeatHit.play()

func _on_Body_area_entered(area):
	if area.is_in_group("bullet"):
		if area.ACTIVE:
			HP -= 15
			area.queue_free()
			$MeatHit.play()

func _on_Legs_area_entered(area):
	if area.is_in_group("bullet"):
		if area.ACTIVE:
			HP -= 5
			legsHP -= 25
			area.queue_free()
			$MeatHit.play()


func _on_Hitbox_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://Scenes/TitleScreen.tscn")
