extends KinematicBody2D



var meleeReady = true
var meleeReadyZombies = []

var pistolActive = true
var arActive = false

export (int) var pistolAmmoReserves = 10
export (int) var pistolAmmo = 12
var maxPistolAmmo = 12
var pistolFiring = false

export (int) var arAmmoReserves = 30
export (int) var arAmmo = 30
var maxARAmmo = 30
var arFiring = false

var pistolCooldown = 1
var pistolCooldownMax = 2

var arCooldown = 1
var arCooldownMax = 6

var reloading = false

var speed = 40
var left = false
var right = false
var up = false
var down = false
var sprinting = false

var zoomed = false

var recoil = 0

var dead = false


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	maxPistolAmmo = get_node("/root/Global").pistolSize
	pistolAmmo = maxPistolAmmo
	
	$playerParts/playerHead1.texture = get_node("/root/Global").currentHead
	$playerParts/playerBody1.texture = get_node("/root/Global").currentBody

	$playerParts/playerHead1.modulate = get_node("/root/Global").headColor
	$playerParts/playerBody1.modulate = get_node("/root/Global").bodyColor



func die():
	if !dead:
		dead = true
		$deathTimer.start()
		$bloodParticles.visible = true
		$playerParts/playerHead1.visible = false
		
		if get_parent().has_node("CanvasLayer/finalTime"):
			get_parent().get_node("CanvasLayer/finalTime").visible = true
			

		if get_parent().name == "Zombies":
			get_node("/root/Global").bestZombiesTime = stepify((OS.get_ticks_usec() - \
				get_parent().get_node("CanvasLayer/TimerCount").start) / 1e+6, 0.01)
			get_parent().get_node("CanvasLayer/finalTime").text = "FINAL TIME:\t" \
				+ String(stepify((OS.get_ticks_usec() - \
				get_parent().get_node("CanvasLayer/TimerCount").start) / 1e+6, 0.01))
			get_node("/root/Global").bestZombiesTime = stepify((OS.get_ticks_usec() - \
				get_parent().get_node("CanvasLayer/TimerCount").start) / 1e+6, 0.01)
				
		elif get_parent().name == "TargetSpeedrun":
			get_node("/root/Global").bestTargetSpeedrunTime = stepify((OS.get_ticks_usec() - \
				get_parent().get_node("CanvasLayer/TimerCount").start) / 1e+6, 0.01)
			get_parent().get_node("CanvasLayer/finalTime").text = "FINAL TIME:\t" \
				+ String(stepify((OS.get_ticks_usec() - \
				get_parent().get_node("CanvasLayer/TimerCount").start) / 1e+6, 0.01))
			get_node("/root/Global").bestTargetSpeedrunTime = stepify((OS.get_ticks_usec() - \
				get_parent().get_node("CanvasLayer/TimerCount").start) / 1e+6, 0.01)
				
		elif get_parent().name == "TargetTimeTrial":
			get_node("/root/Global").bestTimeTrial2Time = String(get_parent().get_node\
			("CanvasLayer/TimerCount/Stopwatch").wait_time)
			get_parent().get_node("CanvasLayer/finalTime").text = "TIME REMAINING:\t" \
				+ String(stepify(get_parent().get_node\
				("CanvasLayer/TimerCount/Stopwatch").time_left, 0.01))
			get_node("/root/Global").bestTimeTrial2Time = stepify(get_parent().get_node\
				("CanvasLayer/TimerCount/Stopwatch").time_left, 0.01)

func _process(_delta):
	
	if !dead:
		
		if arFiring:
			if arCooldown > 0:
				arCooldown -= 1
			else:
				if arAmmo > 0:
					arCooldown = arCooldownMax
					var bulletInstance = load("res://Scenes/Bullet.tscn").instance()
					get_parent().add_child(bulletInstance)
					bulletInstance.damage = get_node("/root/Global").arDamage
					bulletInstance.headshotMultiplier = get_node("/root/Global").arHeadshotMultiplier
					bulletInstance.crippleMultiplier = get_node("/root/Global").arCrippleMultiplier
					bulletInstance.cripplePenalty = get_node("/root/Global").arCripplePenalty
					bulletInstance.global_position = $HandPivot/Pistol/BulletPoint.global_position
					bulletInstance.look_at(get_parent().get_node("AimingReticle").global_position)
					#bulletInstance.look_at(get_parent().get_node("AimingReticle").getPointInSquare())
					bulletInstance.rotate( (  randf() * (recoil*2)  )    - recoil)
					bulletInstance.dest = get_parent().get_node("AimingReticle").global_position
					
					$ReloadBar/PistolShootSound.stop()
					$ReloadBar/PistolShootSound.play()
					
					for zombie in get_tree().get_nodes_in_group("zombie"):
						zombie.hearGunshot(self.global_position)
					
					get_parent().get_node("AimingReticle").recoilReticle(0.65)
					recoil += 0.65
					
					arAmmo -= 1
	
		if pistolFiring:
			if pistolCooldown > 0:
				pistolCooldown -= 1
			else:
				if pistolAmmo > 0:
					$HandPivot/Pistol.play("fire")
					pistolCooldown = pistolCooldownMax
					var bulletInstance = load("res://Scenes/Bullet.tscn").instance()
					get_parent().add_child(bulletInstance)
					bulletInstance.damage = get_node("/root/Global").pistolDamage
					bulletInstance.headshotMultiplier = get_node("/root/Global").pistolHeadshotMultiplier
					bulletInstance.crippleMultiplier = get_node("/root/Global").pistolCrippleMultiplier
					bulletInstance.cripplePenalty = get_node("/root/Global").pistolCripplePenalty
					bulletInstance.global_position = $HandPivot/Pistol/BulletPoint.global_position
					bulletInstance.look_at(get_parent().get_node("AimingReticle").global_position)
					#bulletInstance.look_at(get_parent().get_node("AimingReticle").getPointInSquare())
					bulletInstance.rotate( (  randf() * (recoil*2)  )    - recoil)
					bulletInstance.dest = get_parent().get_node("AimingReticle").global_position
					
					$ReloadBar/PistolShootSound.stop()
					$ReloadBar/PistolShootSound.play()
					
					for zombie in get_tree().get_nodes_in_group("zombie"):
						zombie.hearGunshot(self.global_position)
					
					get_parent().get_node("AimingReticle").recoilReticle(0.65)
					recoil += 0.35
					
					pistolAmmo -= 1
				
	
		#print (recoil)
		recoil = lerp(0.0, recoil, 0.80)
	
		var directionToMouse = get_global_mouse_position() - $HandPivot.global_position
		if abs($HandPivot.rotation - directionToMouse.angle()) > 5:
			$HandPivot.rotation = directionToMouse.angle() * 1.1
		$HandPivot.rotation = lerp($HandPivot.rotation, directionToMouse.angle(), 0.25)
		
		if get_global_mouse_position().x > global_position.x:
			#$HandPivot/Pistol.flip_v = false
			#$HandPivot/ARwithMag.flip_v = false
			#$HandPivot/ARwithoutMag.flip_v = false
			
			$HandPivot.scale = Vector2(1,1)
		else:
			#$HandPivot/Pistol.flip_v = true
			#$HandPivot/ARwithMag.flip_v = true
			#$HandPivot/ARwithoutMag.flip_v = true
	
			$HandPivot.scale = Vector2(1,-1)
			
			
		if reloading:
			$ReloadBar.value = $ReloadBar/ReloadTime.wait_time - $ReloadBar/ReloadTime.time_left
	
		
		if pistolActive:
			var ammoTextLabel = String(pistolAmmo) + "/" + String(maxPistolAmmo)
			get_parent().get_node("CanvasLayer/AmmoCount").text = ammoTextLabel
			get_parent().get_node("CanvasLayer/AmmoReserves").text = String(pistolAmmoReserves)
		elif arActive:
			var ammoTextLabel = String(arAmmo) + "/" + String(maxARAmmo)
			get_parent().get_node("CanvasLayer/AmmoCount").text = ammoTextLabel
			get_parent().get_node("CanvasLayer/AmmoReserves").text = String(arAmmoReserves)
			
	
		# MOVEMENT STUFF
		if left:
			move_and_slide(Vector2.LEFT * speed)
			$playerParts.scale = Vector2(1,1)
		if right:
			move_and_slide(Vector2.RIGHT * speed)
			$playerParts.scale = Vector2(-1,1)
		if up:
			move_and_slide(Vector2.UP * speed)
		if down:
			move_and_slide(Vector2.DOWN * speed)
			
		if left || right || up || down:
			if sprinting:
				get_parent().get_node("AimingReticle").recoilReticle(0.075)
				recoil += 0.075
			else:
				get_parent().get_node("AimingReticle").recoilReticle(0.02)
				recoil += 0.02
			

func _input(event):
	
	if !dead:
	
	
		if event.is_action_pressed("1"):
			pistolActive = true
			pistolFiring = false
			pistolCooldown = 1
			arActive = false
			arFiring = false
			arCooldown = 1
			$HandPivot/Pistol.visible = true
			$HandPivot/ARwithMag.visible = false
			$HandPivot/ARwithoutMag.visible = false
			
			# maybe add a "all false" for better scaling
		elif event.is_action_pressed("2"):
			pistolActive = false
			pistolFiring = false
			pistolCooldown = 1
			arActive = true
			arFiring = false
			arCooldown = 1
			$HandPivot/Pistol.visible = false
			$HandPivot/ARwithMag.visible = true
			$HandPivot/ARwithoutMag.visible = true
	
	
		elif event.is_action_pressed("click"):
			
			if pistolActive:
				
				if get_node("/root/Global").pistolAuto && pistolAmmo > 0:
					pistolFiring = true
					pistolCooldown = 0 
				elif get_node("/root/Global").pistolAuto && pistolAmmo <= 0:
					# CLICK! No ammo.
					$ReloadBar/PistolClick.play()
				
				if pistolAmmo > 0 && !get_node("/root/Global").pistolAuto:
					$HandPivot/Pistol.play("fire")
					var bulletInstance = load("res://Scenes/Bullet.tscn").instance()
					get_parent().add_child(bulletInstance)
					bulletInstance.damage = get_node("/root/Global").pistolDamage
					bulletInstance.headshotMultiplier = get_node("/root/Global").pistolHeadshotMultiplier
					bulletInstance.crippleMultiplier = get_node("/root/Global").pistolCrippleMultiplier
					bulletInstance.cripplePenalty = get_node("/root/Global").pistolCripplePenalty
					bulletInstance.global_position = $HandPivot/Pistol/BulletPoint.global_position
					bulletInstance.look_at(get_parent().get_node("AimingReticle").global_position)
					#bulletInstance.look_at(get_parent().get_node("AimingReticle").getPointInSquare())
					bulletInstance.rotate( (  randf() * (recoil*2)  )    - recoil)
					bulletInstance.dest = get_parent().get_node("AimingReticle").global_position
					
					$ReloadBar/PistolShootSound.stop()
					$ReloadBar/PistolShootSound.play()
					
					for zombie in get_tree().get_nodes_in_group("zombie"):
						zombie.hearGunshot(self.global_position)
					
					get_parent().get_node("AimingReticle").recoilReticle(0.65)
					recoil += 0.35
					
					pistolAmmo -= 1
				else:
					# CLICK! No ammo.
					if get_node("/root/Global").pistolAuto == false:
						$ReloadBar/PistolClick.play()
					
			elif arActive:
				
				arFiring = true
				arCooldown = 0
				
				if arAmmo <= 0:
					# CLICK! No ammo.
					$ReloadBar/PistolClick.play()
					$HandPivot/ARwithMag.visible = false
		
		
		elif event.is_action_pressed("melee"):
			if meleeReady == true:
				meleeReady = false
				$HandPivot/meleeSwipe.visible = true
				$meleeTime.start()
				$meleeDelay.start()
				
				for zomb in meleeReadyZombies:
					zomb.knockback(get_node("/root/Global").meleeKnockback, global_position)
					zomb.HP -= get_node("/root/Global").meleeDamage
					if zomb.HP <= 0:
						zomb.headshotted = true
						zomb.get_node("Timer").start()
		
		elif event.is_action_released("click"):
			if arActive:
				arFiring = false
			if pistolActive:
				pistolFiring = false
		
		
		elif event.is_action_pressed("reload"):
			
			if !reloading:
				
				if pistolActive:
					pistolAmmoReserves += pistolAmmo
					pistolAmmo = 0
					reloading = true
					
					$ReloadBar/ReloadTime.start()
					$ReloadBar.max_value = $ReloadBar/ReloadTime.wait_time
					$ReloadBar.visible = true
					
					$ReloadBar/ReloadSound.play()
					
				elif arActive:
					arAmmoReserves += arAmmo
					arAmmo = 0
					reloading = true
					
					$ReloadBar/ReloadTime.start()
					$ReloadBar.max_value = $ReloadBar/ReloadTime.wait_time
					$ReloadBar.visible = true
					
					$ReloadBar/ReloadSound.play()

	
		elif event.is_action_pressed("esc"):
			get_tree().change_scene("res://Scenes/TitleScreen.tscn")
		elif event.is_action_pressed("restart"):
			get_tree().change_scene("res://Scenes/" + get_tree().get_current_scene().get_name() + ".tscn")
	
		# MOVE STUFF
		elif event.is_action_pressed("left"):
			left = true
		elif event.is_action_pressed("right"):
			right = true
		elif event.is_action_pressed("up"):
			up = true
		elif event.is_action_pressed("down"):
			down = true
		elif event.is_action_pressed("sprint"):
			sprinting = true
			speed = 85
		
		elif event.is_action_released("left"):
			left = false
		elif event.is_action_released("right"):
			right = false
		elif event.is_action_released("up"):
			up = false
		elif event.is_action_released("down"):
			down = false
		elif event.is_action_released("sprint"):
			sprinting = false
			speed = 40
			
		elif event.is_action_pressed("zoom"):
			if zoomed == true:
				zoomed = false
				$Camera2D.zoom = Vector2(0.5, 0.5)
			
			elif zoomed == false:
				zoomed = true
				$Camera2D.zoom = Vector2(0.25, 0.25)
				




func _on_ReloadTime_timeout():
	
	if pistolActive:
	
		if pistolAmmoReserves >= maxPistolAmmo:
			pistolAmmo = maxPistolAmmo
			pistolAmmoReserves -= maxPistolAmmo
		else:
			pistolAmmo += pistolAmmoReserves
			pistolAmmoReserves = 0
	
		reloading = false
		$ReloadBar.visible = false
		
		
		
	elif arActive:
	
		if arAmmoReserves >= maxARAmmo:
			arAmmo = maxARAmmo
			arAmmoReserves -= maxARAmmo
		else:
			arAmmo += arAmmoReserves
			arAmmoReserves = 0
	
		reloading = false
		$ReloadBar.visible = false


func _on_deathTimer_timeout():
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")


func _on_Pistol_animation_finished():
	$HandPivot/Pistol.play("default")


func _on_meleeTime_timeout():
	meleeReady = true


func _on_meleeDelay_timeout():
	$HandPivot/meleeSwipe.visible = false


# MELEE HIT
func _on_Area2D_body_entered(body):
	if $HandPivot/meleeSwipe.visible == true:
		if body.is_in_group("zombie"):
			body.HP -= get_node("/root/Global").meleeDamage
			if body.HP <= 0:
				body.headshotted = true
				body.get_node("Timer").start()
			body.knockback(get_node("/root/Global").meleeKnockback, global_position)
	
	if body.is_in_group("zombie"):
		meleeReadyZombies.append(body)


func _on_Area2D_body_exited(body):
	if body.is_in_group("zombie"):
		meleeReadyZombies.erase(body)
