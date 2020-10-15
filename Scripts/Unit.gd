extends KinematicBody2D



export (int) var pistolAmmoReserves = 10
export (int) var pistolAmmo = 12
var maxPistolAmmo = 12

var reloading = false

var speed = 40
var left = false
var right = false
var up = false
var down = false
var sprinting = false

var recoil = 0

var dead = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func die():
	if !dead:
		dead = true
		$deathTimer.start()
		$bloodParticles.visible = true
		$playerHead.visible = false
		
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
	
		#print (recoil)
		recoil = lerp(0.0, recoil, 0.80)
	
		var directionToMouse = get_global_mouse_position() - $HandPivot.global_position
		if abs($HandPivot.rotation - directionToMouse.angle()) > 5:
			$HandPivot.rotation = directionToMouse.angle() * 1.1
		$HandPivot.rotation = lerp($HandPivot.rotation, directionToMouse.angle(), 0.25)
		
		if $HandPivot/Pistol.global_position.x > global_position.x:
			$HandPivot/Pistol.flip_v = false
		else:
			$HandPivot/Pistol.flip_v = true
	
		if reloading:
			$ReloadBar.value = $ReloadBar/ReloadTime.wait_time - $ReloadBar/ReloadTime.time_left
	
	
		var ammoTextLabel = String(pistolAmmo) + "/" + String(maxPistolAmmo)
		get_parent().get_node("CanvasLayer/AmmoCount").text = ammoTextLabel
		get_parent().get_node("CanvasLayer/AmmoReserves").text = String(pistolAmmoReserves)
	
	
		# MOVEMENT STUFF
		if left:
			move_and_slide(Vector2.LEFT * speed)
		if right:
			move_and_slide(Vector2.RIGHT * speed)
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
	
		if event.is_action_pressed("click"):
			
			if pistolAmmo > 0:
				var bulletInstance = load("res://Scenes/Bullet.tscn").instance()
				get_parent().add_child(bulletInstance)
				bulletInstance.global_position = $HandPivot/Pistol.global_position
				bulletInstance.look_at(get_parent().get_node("AimingReticle").global_position)
				#bulletInstance.look_at(get_parent().get_node("AimingReticle").getPointInSquare())
				bulletInstance.rotate( (  randf() * (recoil*2)  )    - recoil)
				bulletInstance.dest = get_parent().get_node("AimingReticle").global_position
				
				$ReloadBar/PistolShootSound.stop()
				$ReloadBar/PistolShootSound.play()
				
				for zombie in get_tree().get_nodes_in_group("zombie"):
					zombie.hearGunshot()
				
				get_parent().get_node("AimingReticle").recoilReticle(0.65)
				recoil += 0.35
				
				pistolAmmo -= 1
				
			
			else:
				# CLICK! No ammo.
				$ReloadBar/PistolClick.play()
		
		elif event.is_action_pressed("reload"):
			
			if !reloading:
				pistolAmmoReserves += pistolAmmo
				pistolAmmo = 0
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




func _on_ReloadTime_timeout():
	if pistolAmmoReserves >= maxPistolAmmo:
		pistolAmmo = maxPistolAmmo
		pistolAmmoReserves -= maxPistolAmmo
	else:
		pistolAmmo += pistolAmmoReserves
		pistolAmmoReserves = 0

	reloading = false
	$ReloadBar.visible = false


func _on_deathTimer_timeout():
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")
