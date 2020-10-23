extends Panel



var headRed
var headGreen
var headBlue

var bodyRed
var bodyGreen
var bodyBlue

var currentHead
var currentBody

var heads = []
var headIndex = 0
var bodies = []
var bodyIndex = 0

func _ready():
	currentHead = load("res://Images/playerParts/playerHead1.png")
	currentBody = load("res://Images/playerParts/playerBody1.png")
	
	heads.append(load("res://Images/playerParts/playerHead1.png"))
	heads.append(load("res://Images/playerParts/playerHead2.png"))
	bodies.append(load("res://Images/playerParts/playerBody1.png"))
	bodies.append(load("res://Images/playerParts/playerBody2.png"))
	bodies.append(load("res://Images/playerParts/playerBody3.png"))
	
	updateParts()


func updateValues():
	headRed = $headRSlider.value
	headBlue = $headGSlider.value
	headGreen = $headBSlider.value
	
	bodyRed = $bodyRSlider.value
	bodyGreen = $bodyGSlider.value
	bodyBlue = $bodyBSlider.value


func updateParts():
	updateValues()
	$playerHead1.texture = currentHead
	$playerBody1.texture = currentBody
	$playerHead1.modulate = Color(headRed/255, headBlue/255, headGreen/255)
	$playerBody1.modulate = Color(bodyRed/255, bodyBlue/255, bodyGreen/255)

	get_node("/root/Global").currentHead = currentHead
	get_node("/root/Global").headColor = Color(headRed/255, headBlue/255, headGreen/255)
	get_node("/root/Global").currentBody = currentBody
	get_node("/root/Global").bodyColor = Color(bodyRed/255, bodyBlue/255, bodyGreen/255)



func _on_headRSlider_value_changed(value):
	updateParts()
func _on_headGSlider_value_changed(value):
	updateParts()
func _on_headBSlider_value_changed(value):
	updateParts()
func _on_bodyRSlider_value_changed(value):
	updateParts()
func _on_bodyGSlider_value_changed(value):
	updateParts()
func _on_bodyBSlider_value_changed(value):
	updateParts()


func _on_headRight_pressed():
	if heads.size() > 1:
		if headIndex < heads.size()-1:
			headIndex += 1
		else:
			headIndex = 0
		
		currentHead = heads[headIndex]
		updateParts()
func _on_headLeft_pressed():
	if heads.size() > 1:
		if headIndex-1 < 0:
			headIndex = heads.size()-1
		else:
			headIndex -= 1
		
		currentHead = heads[headIndex]
		updateParts()


func _on_bodyRight_pressed():
	if bodies.size() > 1:
		if bodyIndex < bodies.size()-1:
			bodyIndex += 1
		else:
			bodyIndex = 0
		
		currentBody = bodies[bodyIndex]
		updateParts()
func _on_bodyLeft_pressed():
	if bodies.size() > 1:
		if bodyIndex-1 < 0:
			bodyIndex = bodies.size()-1
		else:
			bodyIndex -= 1
		
		currentBody = bodies[bodyIndex]
		updateParts()



