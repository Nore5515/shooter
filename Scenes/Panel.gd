extends Panel

var tut = false
var targetSpeedrun = false
var targetTimeTrial = false
var movingTargets = false
var zombies = false
var zombieTown = false
var default = false


func resetStuff():
	tut = false
	targetSpeedrun = false
	targetTimeTrial = false
	movingTargets = false
	zombies = false
	$ScenarioPic.texture = null
	$ScenarioDesc.text = ""
	$BestTime.text = ""

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
		$ScenarioPic.texture = load("res://Images/timeTrialPreview.PNG")
		$BestTime.text = "Best Time: " + String(\
			get_node("/root/Global").bestTargetSpeedrunTime)


func _on_TargetTimeTrial2_pressed():
	if targetTimeTrial:
		targetTimeTrial = false
		resetStuff()
	else:
		resetStuff()
		targetTimeTrial = true
		$ScenarioDesc.text = "Can you destroy all the targets in the given time?"
		$ScenarioPic.texture = load("res://Images/timeTrialPreview.PNG")
		$BestTime.text = "Best Time Remaining: " + String(\
			get_node("/root/Global").bestTimeTrial2Time)


func _on_Start_pressed():
	if tut:
		get_tree().change_scene("res://Scenes/Tutorial.tscn")
	elif targetSpeedrun:
		get_tree().change_scene("res://Scenes/TargetSpeedrun.tscn")
	elif targetTimeTrial:
		get_tree().change_scene("res://Scenes/TargetTimeTrial.tscn")
	elif movingTargets:
		get_tree().change_scene("res://Scenes/MovingTargets.tscn")
	elif zombies:
		get_tree().change_scene("res://Scenes/Zombies.tscn")
	elif zombieTown:
		get_tree().change_scene("res://Scenes/ZombieTown.tscn")
	elif default:
		get_tree().change_scene("res://Scenes/DefaultLevel.tscn")
		
		


func _on_Quit_pressed():
	get_tree().quit()


func _on_MovingTargets_pressed():
	if movingTargets:
		movingTargets = false
		resetStuff()
	else:
		resetStuff()
		movingTargets = true
		$ScenarioDesc.text = "Destroy all targets! Missing one will result in a game over!"
		$ScenarioPic.texture = load("res://Images/timeTrialPreview.PNG")
		


func _on_Zombies_pressed():
	if zombies:
		zombies = false
		resetStuff()
	else:
		resetStuff()
		zombies = true
		$ScenarioDesc.text = "Zombies! Survive as long as you can!"
		$ScenarioPic.texture = load("res://Images/zombiesPreview.PNG")
		$BestTime.text = "Best Time: " + String(\
			get_node("/root/Global").bestZombiesTime)


func _on_Zombies2_pressed():
	if zombieTown:
		zombieTown = false
		resetStuff()
	else:
		resetStuff()
		zombieTown = true
		$ScenarioDesc.text = "Clear out the infected town!"
		$ScenarioPic.texture = load("res://Images/zombieTownScreenshot.PNG")
		$BestTime.text = "Best Time: " + String(\
			get_node("/root/Global").bestZombiesTime)



func _on_Default_pressed():
	if default:
		default = false
		resetStuff()
	else:
		resetStuff()
		default = true
		$ScenarioDesc.text = "A default, example map."
		#$ScenarioPic.texture = load("res://Images/zombieTownScreenshot.PNG")
		#$BestTime.text = "Best Time: " + String(\
			#get_node("/root/Global").bestZombiesTime)


func _on_Campaign_pressed():
	get_tree().change_scene("res://Scenes/Campaign/CampaignMap.tscn")
