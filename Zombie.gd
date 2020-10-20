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

export (bool) var bigbrainZombieMoving = false
var navDest
var lastNav

var lastSceenPos = Vector2()

var moving = true
var relax = true
var relax2 = true

var yelling = false

func _ready():
	lastSceenPos = position
	navDest = global_position

func _process(delta):
	moving = true
	$ProgressBar.value = HP
	
	if relax == false:
		if relax2 == false:
			relax2 = true
		else:
			#$Detection/DetectionSphere.shape.radius = 60
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
		if bigbrainZombieMoving == false:
			var collision = move_and_collide(global_position.direction_to(playerPos) * speed * delta)
		else:
			# have the zombie pathfind if out of range (range being like 100)
			if self.global_position.distance_to(playerPos) < 100:
				var collision = move_and_collide(global_position.direction_to(playerPos) * speed * delta)
			else:
				var collision = move_and_collide(global_position.direction_to(navDest) * speed * delta)


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
		get_node("/root/Global").cash += 1
		queue_free()

	if global_position.direction_to(playerPos).x > 0:
		$ZombieSpriteParts.scale.x = 1
	else:
		$ZombieSpriteParts.scale.x = -1
		
	if global_position.distance_to\
	(get_tree().get_nodes_in_group("player")[0].global_position) < 30:
		yelling = true
		if !legsBroken:
			speed = 40
	else:
		yelling = false
		if !legsBroken:
			speed = 25
		
		
	hideAll()
	
	if headshotted:
		speed = 10
		$ZombieSpriteParts/zombieDead.visible = true
		$bloodParticles.visible = true
	
	else:
		if yelling:
			$ZombieSpriteParts/zombieAttacking.visible = true
		else:
			
			if moving:
				$ZombieSpriteParts/zombieSeeking.visible = true
			else:
				
				$ZombieSpriteParts/zombieIdle.visible = true
	
	
	if global_position.direction_to(playerPos).y < 0:
		hideAll()
		$ZombieSpriteParts/zombieBack.visible = true
	
	if global_position.direction_to(playerPos).y < 0 && headshotted:
		hideAll()
		$ZombieSpriteParts/zombieBackDead.visible = true
		
	
	if moving && !headshotted:
		$ZombieSpriteParts/zombieLArmPivot.look_at(playerPos)
		$ZombieSpriteParts/zombieLArmPivot.rotation_degrees -= 90
		$ZombieSpriteParts/zombieRArmPivot.look_at(playerPos)
		$ZombieSpriteParts/zombieRArmPivot.rotation_degrees -= 90
	
	
			
		
	
	


func hideAll():
	$ZombieSpriteParts/zombieAttacking.visible = false
	$ZombieSpriteParts/zombieBack.visible = false
	$ZombieSpriteParts/zombieIdle.visible = false
	$ZombieSpriteParts/zombieSeeking.visible = false
	$ZombieSpriteParts/zombieDead.visible = false
	$ZombieSpriteParts/zombieBackDead.visible = false


func _on_Head_area_entered(area):
	if area.is_in_group("bullet") && !headshotted:
		if area.ACTIVE:
			HP -= 115
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

# Death
func _on_Timer_timeout():
	if crateDropOdds > 0:
			if rand_range(0, 100) < crateDropOdds:
				var crateInstance = load("res://Scenes/Crate.tscn").instance()
				crateInstance.global_position = global_position
				get_parent().add_child(crateInstance)
	var soundInstance = load("res://Scenes/Deathsound.tscn").instance()
	get_parent().add_child(soundInstance)
	get_node("/root/Global").cash += 2
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


func hearGunshot(gunshotLoc):
	
	if gunshotLoc.distance_to(self.global_position) < 200:
		lastSceenPos = gunshotLoc
	
	#$Detection/DetectionSphere.shape.radius = 200
	relax = false
	relax2 = false
	


func _on_rArm_body_entered(body):
	if body.is_in_group("player"):
		if !headshotted:
			body.die()


func _on_rArm2_body_entered(body):
	if body.is_in_group("player"):
		if !headshotted:
			body.die()
