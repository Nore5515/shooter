extends Node2D


var maxTargets = 0
var wave = 0


func _process(delta):
	
	var targetString = String(maxTargets - get_tree().get_nodes_in_group("wave" + String(wave)).size())
	targetString += "/"
	targetString += String(maxTargets)
	$CanvasLayer/TargetsHit.text = targetString
	$CanvasLayer/Wave.text = String(wave)


func wave1():
	wave = 1
	maxTargets = get_tree().get_nodes_in_group("wave1").size()
	
	for target in get_tree().get_nodes_in_group("wave1"):
		target.moving = true

func wave2():
	wave = 2
	maxTargets = get_tree().get_nodes_in_group("wave2").size()
	
	for target in get_tree().get_nodes_in_group("wave2"):
		target.moving = true



func _on_StartDelay_timeout():
	wave1()
	$Wave1.start()

func _on_Wave1_timeout():
	
	if get_tree().get_nodes_in_group("wave1").size() > 0:
		get_tree().change_scene("res://Scenes/" + get_tree().get_current_scene().get_name() + ".tscn")
	else:
		wave2()
		$Wave2.start()


func _on_Wave2_timeout():
	if get_tree().get_nodes_in_group("wave2").size() > 0:
		get_tree().change_scene("res://Scenes/" + get_tree().get_current_scene().get_name() + ".tscn")
	else:
		get_tree().change_scene("res://Scenes/TitleScreen.tscn")
		wave2()
		$Wave2.start()
