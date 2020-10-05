extends KinematicBody2D



var pistolAmmoReserves = 10
var pistolAmmo = 12
var maxPistolAmmo = 12

var reloading = false

var speed = 25
var left = false
var right = false
var up = false
var down = false
var sprinting = false



func _process(_delta):
	

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
			get_parent().get_node("AimingReticle").recoilReticle(0.06)
		else:
			get_parent().get_node("AimingReticle").recoilReticle(0.03)
			

func _input(event):
	if event.is_action_pressed("click"):
		
		if pistolAmmo > 0:
			var bulletInstance = load("res://Scenes/Bullet.tscn").instance()
			get_parent().add_child(bulletInstance)
			bulletInstance.global_position = $HandPivot/Pistol.global_position
			bulletInstance.look_at(get_parent().get_node("AimingReticle").getPointInSquare())
			
			$ReloadBar/PistolShootSound.stop()
			$ReloadBar/PistolShootSound.play()
			
			get_parent().get_node("AimingReticle").recoilReticle(0.5)
			
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
		speed = 75
	
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
		speed = 25
		
	



func _on_ReloadTime_timeout():
	if pistolAmmoReserves >= maxPistolAmmo:
		print ("what")
		pistolAmmo = maxPistolAmmo
		pistolAmmoReserves -= maxPistolAmmo
	else:
		print ("no")
		pistolAmmo += pistolAmmoReserves
		pistolAmmoReserves = 0

	reloading = false
	$ReloadBar.visible = false
