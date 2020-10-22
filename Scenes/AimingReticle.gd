extends Node2D



var baseScalePistol = Vector2(0.2,0.2)
var baseScaleAR = Vector2(0.1,0.1)
var baseScale
var clickScale = Vector2(0,0)#Vector2(baseScale.x + baseScale.x * 0.1,baseScale.y + baseScale.y * 0.1)

var idealRangePistol = 60
var idealRangeAR = 120
var easeMod = 0.9

func _ready():
	randomize()


func _process(_delta):
	position = get_global_mouse_position()
	
	if get_tree().get_nodes_in_group("player").size() > 0:
		if get_tree().get_nodes_in_group("player")[0].pistolActive:
			var playerPosition = get_parent().get_node("Unit").global_position 
			var distance = global_position.distance_to(playerPosition)
			var distanceMod = (distance-idealRangePistol) * (distance-idealRangePistol)
			distanceMod = distanceMod / 10
			distanceMod = 1 + (distanceMod * 0.01)
			baseScale = Vector2(0.2, 0.2) * distanceMod
			baseScale = baseScalePistol
		elif get_tree().get_nodes_in_group("player")[0].arActive:
			var playerPosition = get_parent().get_node("Unit").global_position 
			var distance = global_position.distance_to(playerPosition)
			var distanceMod = (distance-idealRangeAR) * (distance-idealRangeAR)
			distanceMod = distanceMod / 10
			distanceMod = 1 + (distanceMod * 0.01)
			baseScale = Vector2(0.2, 0.2) * distanceMod
			baseScale = baseScaleAR

	clickScale = Vector2(baseScale.x + baseScale.x * 0.1,baseScale.y + baseScale.y * 0.1)

	if scale != null:
		if scale < clickScale:
			scale = clickScale
		else:
			scale = lerp(scale,baseScale, 0.035)



func recoilReticle(recoilAmount):
	scale += Vector2(recoilAmount, recoilAmount)
	

func getPointInSquare():
	var size = get_node("AimingSquare").texture.get_size() * scale
	size *= easeMod
	var point = Vector2(randf() * (size.x * 2), randf() * (size.y * 2))
	point -= Vector2(size.x, size.y)
	point += position
	return point

