extends Node2D



var secretInput = []

var secret1 = false

# +$1000
var secretCode = [1,4,1,5,1]

# infinite ammo
var secretCode2 = [5,5,1,5]


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process(delta):
	$Cash.text = "$" + String(get_node("/root/Global").cash)

func _on_VideoPlayer_finished():
	print ("new")
	$VideoPlayer.play()


func hideAll():
	$Begin/Panel.visible = false
	$Shop/ItemSelect.visible = false
	$Shop.hideAll()
	$Customize/CustomizePanel.visible = false


func _on_Begin_pressed():
	if $Begin/Panel.visible == true:
		hideAll()
	else:
		hideAll()
		$Begin/Panel.visible = true


func _on_Shop_pressed():
	if $Shop/ItemSelect.visible == true:
		$Shop.hideAll()
		hideAll()
	else:
		hideAll()
		$Shop/ItemSelect.visible = true



func _on_Customize_pressed():
	if $Customize/CustomizePanel.visible == true:
		hideAll()
	else:
		hideAll()
		$Customize/CustomizePanel.visible = true



func _input(event):
	
	if event.is_action_pressed("1"):
		secretInput.append (1)
	elif event.is_action_pressed("2"):
		secretInput.append(2)
	elif event.is_action_pressed("3"):
		secretInput.append(3)
	elif event.is_action_pressed("4"):
		secretInput.append(4)
	elif event.is_action_pressed("5"):
		secretInput.append(5)
	elif event.is_action_pressed("esc"):
		secretInput = []
		
	if secretInput == secretCode:
		get_node("/root/Global").cash += 1000
		secretInput = []
	elif secretInput == secretCode2:
		get_node("/root/Global").infAmmo = true
		secretInput = []
		
	$secret.text = String(secretInput)
