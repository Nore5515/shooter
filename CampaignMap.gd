extends Node2D


# Either 1 or 2
var firstChoice = false

# 3 or 4, only available if 1 is picked
var secondChoice = false

var boss = false
var escape = false



# Called when the node enters the scene tree for the first time.
func _ready():
	firstChoice = get_node("/root/Global").firstChoice
	secondChoice = get_node("/root/Global").secondChoice
	boss = get_node("/root/Global").boss
	escape = get_node("/root/Global").escape

	processLevel()

	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)



func reloadVars():
	firstChoice = get_node("/root/Global").firstChoice
	secondChoice = get_node("/root/Global").secondChoice
	boss = get_node("/root/Global").boss
	escape = get_node("/root/Global").escape


func processLevel():
	reloadVars()
	if firstChoice:
		showShade()
		$shade1.visible = false
		$shade2.visible = false
	elif secondChoice:
		showShade()
		$shade3.visible = false
		$shade4.visible = false
	elif boss:
		showShade()
		$shade5.visible = false
	elif escape:
		showShade()
		$escapeStuff.visible = true
		#$shade6.visible = false
	else:
		get_node("/root/Global").firstChoice = true
		processLevel()

func _input(event):
	if event.is_action_pressed("esc"):
		get_tree().change_scene("res://Scenes/TitleScreen.tscn")

func hideShade():
	$shade1.visible = false
	$shade2.visible = false
	$shade3.visible = false
	$shade4.visible = false
	$shade5.visible = false
	#$shade6.visible = false

func showShade():
	$shade1.visible = true
	$shade2.visible = true
	$shade3.visible = true
	$shade4.visible = true
	$shade5.visible = true
	$escapeStuff.visible = false
	#$shade6.visible = true


func _on_level1_pressed():
	if firstChoice:
		# LOAD LEVEL 1
		get_node("/root/Global").firstChoice = false
		get_node("/root/Global").secondChoice = true
		processLevel()
		get_tree().change_scene("res://Scenes/Campaign/CampaignLevel1.tscn")


func _on_level2_pressed():
	if firstChoice:
		# LOAD LEVEL 2
		get_node("/root/Global").firstChoice = false
		get_node("/root/Global").boss = true
		processLevel()

func _on_level3_pressed():
	if secondChoice:
		# LOAD LEVEL 3
		get_node("/root/Global").secondChoice = false
		get_node("/root/Global").boss = true
		processLevel()


func _on_level4_pressed():
	if secondChoice:
		# LOAD LEVEL 4
		get_node("/root/Global").secondChoice = false
		get_node("/root/Global").boss = true
		processLevel()


func _on_level5_pressed():
	if boss:
		# LOAD LEVEL 5 AKA BOSS
		get_node("/root/Global").boss = false
		get_node("/root/Global").escape = true
		processLevel()


func _on_level6_pressed():
	if escape:
		# LOAD LEVEL 6 AKA ESCAPE
		get_node("/root/Global").escape = false
		processLevel()



