extends Panel

var tut = false
var targetSpeedrun = false
var targetTimeTrial = false


func resetStuff():
	tut = false
	targetSpeedrun = false
	targetTimeTrial = false

func _on_Tutorial_pressed():
	resetStuff()
	tut = true
	$ScenarioDesc.text = "This is the tutorial. Start here for a quick rundown on the basics!"


func _on_TargetSpeedrun_pressed():
	resetStuff()
	targetSpeedrun = true
	$ScenarioDesc.text = "Try to destroy all the targets as quickly as possible!"


func _on_TargetTimeTrial2_pressed():
	resetStuff()
	targetTimeTrial = true
	$ScenarioDesc.text = "Can you destroy all the targets in the given time?"


func _on_Button_pressed():
	visible = !visible


func _on_Start_pressed():
	pass
