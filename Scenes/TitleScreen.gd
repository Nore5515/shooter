extends Node2D



func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)



func _on_VideoPlayer_finished():
	print ("new")
	$VideoPlayer.play()

