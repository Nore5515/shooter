extends Panel

var tut = false
var targetSpeedrun = false
var targetTimeTrial = false


func resetStuff():
	tut = false
	targetSpeedrun = false
	targetTimeTrial = false
	$ScenarioPic.texture = null
	$ScenarioDesc.text = ""

func _on_Tutorial_pressed():
	if tut:
		tut = false
		resetStuff()
	else:
		resetStuff()
		tut = true
		$ScenarioDesc.text = "This is the tutorial. Start here for a quick rundown on the basics!"
		$ScenarioPic.texture = load("res://Images/tutPreview.PNG")


func _on_TargetSpeedrun_pressed():
	if targetSpeedrun:
		targetSpeedrun = false
		resetStuff()
	else:
		resetStuff()
		targetSpeedrun = true
		$ScenarioDesc.text = "Try to destroy all the targets as quickly as possible!"


func _on_TargetTimeTrial2_pressed():
	if targetTimeTrial:
		targetTimeTrial = false
		resetStuff()
	else:
		resetStuff()
		targetTimeTrial = true
		$ScenarioDesc.text = "Can you destroy all the targets in the given time?"


func _on_Button_pressed():
	visible = !visible


func _on_Start_pressed():
	if tut:
		get_tree().change_scene("res://Scenes/Tutorial.tscn")
	elif targetSpeedrun:
		get_tree().change_scene("res://Scenes/TargetSpeedrun.tscn")
	elif targetTimeTrial:
		get_tree().change_scene("res://Scenes/TargetTimeTrial.tscn")
