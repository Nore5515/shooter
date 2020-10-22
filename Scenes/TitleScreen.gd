extends Node2D



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


func _on_Begin_pressed():
	if $Begin/Panel.visible == true:
		hideAll()
	else:
		hideAll()
		$Begin/Panel.visible = true


func _on_Shop_pressed():
	if $Shop/ItemSelect.visible == true:
		hideAll()
	else:
		hideAll()
		$Shop/ItemSelect.visible = true

