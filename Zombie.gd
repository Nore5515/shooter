extends KinematicBody2D


var playerLoc
var speed = 30

var maxHP = 100
var HP = 100
var legsHP = 20
var legsBroken = false

var headshotted = false

export (float) var crateDropOdds = 0

var playerPos = Vector2()

export (bool) var idleZombie = false

var lastSceenPos = Vector2()

var moving = true
var relax = true
var relax2 = true

func _ready():
	lastSceenPos = position

func _process(delta):
	moving = true
	$ProgressBar.value = HP
	
	if relax == false:
		if relax2 == false:
			relax2 = true
		else:
			$Detection/DetectionSphere.shape.radius = 60
			relax = true
	
	if !headshotted:
		if idleZombie == false:
			playerPos = get_tree().get_nodes_in_group("player")[0].global_position
			lastSceenPos = playerPos
		else:
			playerPos = lastSceenPos
			if global_position.distance_to(playerPos) < 3:
				moving = false

	if moving:
		var collision = move_and_collide(global_position.direction_to(playerPos) * speed * delta)
	#if collision:
		#print (collision.collider.name)

	if legsHP <= 0 && legsBroken == false:
		$Legsnap.play()
		legsBroken = true
		speed = 5
	
	if HP <= 0 && !headshotted:
		if crateDropOdds > 0:
			if rand_range(0, 100) < crateDropOdds:
				var crateInstance = load("res://Scenes/Crate.tscn").instance()
				crateInstance.global_position = global_position
				get_parent().add_child(crateInstance)
		var soundInstance = load("res://Scenes/Deathsound.tscn").instance()
		get_parent().add_child(soundInstance)
		queue_free()

	if global_position.direction_to(playerPos).x > 0:
		$zombieBody.flip_h = true
		$zombieHead.flip_h = true
	else:
		$zombieBody.flip_h = false
		$zombieHead.flip_h = false
		
	if global_position.distance_to\
	(get_tree().get_nodes_in_group("player")[0].global_position) < 30:
		$openMouthHead.visible = true
		$zombieHead2.visible = false
		if !legsBroken:
			speed = 40
	else:
		$openMouthHead.visible = false
		$zombieHead2.visible = true
		if !legsBroken:
			speed = 25
		
	if headshotted:
		speed = 10
		$openMouthHead.visible = false
		$zombieHead2.visible = false
		$deadHead.visible = true
		$bloodParticles.visible = true
		
	#if global_position.direction_to(playerPos).x 

func _on_Head_area_entered(area):
	if area.is_in_group("bullet") && !headshotted:
		if area.ACTIVE:
			HP -= 90
			area.queue_free()
			$MeatHit.play()
			if HP <= 0:
				headshotted = true
				$Timer.start()
				

func _on_Body_area_entered(area):
	if area.is_in_group("bullet") && !headshotted:
		if area.ACTIVE:
			HP -= 15
			area.queue_free()
			$MeatHit.play()

func _on_Legs_area_entered(area):
	if area.is_in_group("bullet") && !headshotted:
		if area.ACTIVE:
			HP -= 5
			legsHP -= 25
			area.queue_free()
			$MeatHit.play()


func _on_Hitbox_body_entered(body):
	if body.is_in_group("player"):
		if !headshotted:
			body.die()
			#get_tree().change_scene("res://Scenes/TitleScreen.tscn")

# Death
func _on_Timer_timeout():
	if crateDropOdds > 0:
			if rand_range(0, 100) < crateDropOdds:
				var crateInstance = load("res://Scenes/Crate.tscn").instance()
				crateInstance.global_position = global_position
				get_parent().add_child(crateInstance)
	var soundInstance = load("res://Scenes/Deathsound.tscn").instance()
	get_parent().add_child(soundInstance)
	queue_free()


func _on_Detection_body_entered(body):
	if body.is_in_group("zombie"):
		if body.idleZombie == true:
			playerPos = body.global_position
	elif body.is_in_group("player"):
		if idleZombie == true:
			idleZombie = false
			


func _on_Detection_body_exited(body):
	if body.is_in_group("player"):
		if idleZombie == false:
			idleZombie = true


func hearGunshot():
	$Detection/DetectionSphere.shape.radius = 200
	relax = false
	relax2 = false
	
