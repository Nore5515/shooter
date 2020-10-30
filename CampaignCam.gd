extends KinematicBody2D




var movingLeft = false
var movingRight = false
var movingUp = false
var movingDown = false


func _process(delta):

	move_and_slide(get_global_mouse_position() - global_position)
